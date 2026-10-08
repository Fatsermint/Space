extends Node2D
var basicScene: PackedScene = preload("res://Scenes/basic.tscn")
var playerScene: PackedScene = preload("res://Scenes/player.tscn")
var settingsScene: PackedScene = preload("res://Scenes/settings.tscn")
@onready var camera: Camera2D = $Camera
@onready var bullets: Node = $bullets

var settings = settingsScene.instantiate()


func generate_level(levelNum):
	var level = GlobalVariables.levels[levelNum]
	var root = get_tree().get_root()

	
	if level["player"][1] == true:
		var player = playerScene.instantiate()
		add_child(player)
		player.global_position = Vector2(level["player"][0][0], level["player"][0][1])
		
		
	for i in level["basic"]:
		var basic = basicScene.instantiate()
		add_child(basic)
		basic.add_to_group("enemy")
		basic.global_position = Vector2(i[0][0], i[0][1])
		basic.find_child("health").value = i[1]
		
	if level.has("settings") and level["settings"] == true:
		settings = settingsScene.instantiate()
		add_child(settings)
		
	
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		
		settings.get_child(0).visible = not settings.get_child(0).visible
		pause_gameplay()
		
func pause_gameplay():
	if get_child(0).process_mode == Node.PROCESS_MODE_DISABLED:
		for child in self.get_children():
			child.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		for child in self.get_children():
			
			child.process_mode = Node.PROCESS_MODE_DISABLED
func _ready() -> void:
	generate_level(GlobalVariables.playerInfo["level"])

func _process(delta: float) -> void:

	if get_tree().get_nodes_in_group("enemy").is_empty():
		_finis_level()
	for b in self.find_child("bullets").get_children():
		if b.position.y < -1000:
			print("bullet deleted")
			b.queue_free()

func _finis_level():
	for child in get_children():
		if not GlobalVariables.whitelistedObjectsNames.has(child.name):
			child.queue_free()
	GlobalVariables.playerInfo["level"] += 1
	generate_level(GlobalVariables.playerInfo["level"])
