extends Node2D
var basicScene: PackedScene = preload("res://Scenes/basic.tscn")
var playerScene: PackedScene = preload("res://Scenes/player.tscn")
var settingsScene: PackedScene = preload("res://Scenes/settings.tscn")
@onready var camera: Camera2D = $Camera
@onready var bullets: Node = $bullets

var settings = settingsScene.instantiate()
var finishing = false

func generate_level(levelNum):
	var level = GlobalVariables.levels[levelNum]
	var root = get_tree().get_root()

	
	if level["player"][1] == true:
		var player = playerScene.instantiate()
		add_child(player)
		player.global_position = Vector2(level["player"][0][0], level["player"][0][1])
		
	if level.has("basic"):
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
			if not child.is_in_group("disabledFromPause"):
				child.process_mode = Node.PROCESS_MODE_DISABLED
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("enemy").is_empty() and finishing == false:
		
		_finish_level_text()
		finishing = true
	if self.find_child("bullets"):
		
		for b in self.find_child("bullets").get_children():
			if b.position.y < -1000:
				
				b.queue_free()
	else:
		var newNode = Node.new()
		add_child(newNode)
		newNode.name = "bullets"
func _finish_level_text():
	var position1 = Vector2(-113, -820.0)
	var position2 = Vector2(-113, 100)
	
	
	var label = $Label
	var tween = create_tween()
	label.text = "Level "+str(GlobalVariables.playerInfo["level"]+1) 
	label.position.y = -1500
	label.visible = true
	tween.tween_property(label, "position", position1, 0.2)
	
	await get_tree().create_timer(3, false).timeout
	var tween2 = create_tween()
	
	tween2.tween_property(label, "position", position2, 0.2)
	await get_tree().create_timer(0.8, false).timeout
	_finis_level(GlobalVariables.playerInfo["level"])
	
	print(GlobalVariables.playerInfo["level"])


func _finis_level(level):
	for child in get_children():
		if not GlobalVariables.whitelistedObjectsNames.has(child.name):
			child.queue_free()
	GlobalVariables.playerInfo["level"] = level +1
	print(GlobalVariables.playerInfo["level"])
	
	generate_level(GlobalVariables.playerInfo["level"])
	finishing = false
