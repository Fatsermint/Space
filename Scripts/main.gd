extends Node2D
var enemy1: PackedScene = preload("res://Scenes/basic.tscn")
var playerScene: PackedScene = preload("res://Scenes/player.tscn")
var enemy2:PackedScene = preload("res://Scenes/enemy_2.tscn")
var settingsScene: PackedScene = preload("res://Scenes/settings.tscn")
var cageScene: PackedScene = preload("res://Scenes/cage.tscn")
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
		

		for i in level:
			for enemytype in GlobalVariables.enemyInfo:
				if i == enemytype:
					var num = 0
					for enemychild in GlobalVariables.levels[levelNum][enemytype].size():
						var eneminfo = GlobalVariables.enemyInfo[enemytype]
						var path = eneminfo.path
						var packedScene:PackedScene = load(path)
						var enem = packedScene.instantiate()
						enem.editor_description = str(enemytype)
						add_child(enem)
						if not eneminfo.child == null:
							enem.add_to_group("newChild")
						enem.add_to_group("enemy")
						enem.name = str(1)
						enem.global_position = Vector2(level[enemytype][num][0][0], level[enemytype][num][0][1])
						enem.find_child("health").value = level[enemytype][num][1]
						num = num +1
						
	if level["cages"] == true:
		Generate_Cages()
	
	if level.has("settings") and level["settings"] == true:
		settings = settingsScene.instantiate()
		add_child(settings)
		
	
	
func Generate_Cages():

	for random in randi_range(10, 50):
			var cage = cageScene.instantiate()
			call_deferred("add_child", cage)
			cage.global_position = Vector2(randi_range(-250, 250),randi_range(-1000, -1200))
			print("cage genrated at: ", cage.global_position)
			cage.add_to_group("cage")
			if randi_range(0,100) >50:
				cage.texture = load("res://Assets/bad_cage.svg")
	
func newEnemy(position, type, parentType):
	var num = 0
	for i in GlobalVariables.enemyInfo[parentType]["child"]["positions"]:
		
		var enemyInfo = GlobalVariables.enemyInfo[parentType]
		var path = GlobalVariables.enemyInfo[type].path
		var packedScene:PackedScene = load(path)
		var enem = packedScene.instantiate()
		enem.editor_description = str(type)
		call_deferred("add_child", enem)
		if not GlobalVariables.enemyInfo[type].child == null:
			enem.add_to_group("newChild")
		enem.add_to_group("enemy")
		enem.name = str(1)
		print(enemyInfo["child"]["positions"][num])
		enem.global_position = Vector2(enemyInfo["child"]["positions"][num][0] + position[0], enemyInfo["child"]["positions"][num][1]+position[1])
		enem.find_child("health").value = enemyInfo.child.hp
		num += 1

		
		
		
		
func check_end_level(selfEnemy):
	var end = true
	for child in get_children():
		if child.is_in_group("enemy") or child.is_in_group("newChild") and child == selfEnemy:
			print(selfEnemy)
			print(child)
			
			if not child == selfEnemy:
				print("idik")
				end = false
		else:
			pass
	if end == true:
		_finish_level_text()
	end = true
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
	generate_level(GlobalVariables.playerInfo["level"]+1)

func _process(delta: float) -> void:
	if GlobalVariables.playerInfo.failed == true:
		get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
		
	do_effects(delta)
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
	

func do_effects(delta):
	var effects = GlobalVariables.playerInfo["effects"]
	for effect in effects:
		var TheEffect= GlobalVariables.playerInfo["effects"][effect]
		if not TheEffect["time"]== null:
			TheEffect["time"] -= delta
			if TheEffect["time"] <= 0:
				GlobalVariables.playerInfo["effects"].erase(effect)

func _finis_level(level):
	for child in get_children():
		if not GlobalVariables.whitelistedObjectsNames.has(child.name):
			child.queue_free()
	GlobalVariables.playerInfo["level"] = level +1
	
	generate_level(GlobalVariables.playerInfo["level"])
	finishing = false
