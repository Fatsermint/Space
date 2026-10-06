extends Node2D
var basicScene: PackedScene = preload("res://Scenes/basic.tscn")
var playerScene: PackedScene = preload("res://Scenes/player.tscn")




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
		basic.global_position = Vector2(i[0][0], i[0][1])
		basic.find_child("health").value = i[1]
		
	
	
	
func _ready() -> void:
	generate_level(1)
