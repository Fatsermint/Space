extends Node2D
@onready var output: CodeEdit = $CodeEdit
@onready var level_num: LineEdit = $LevelSettings/VBoxContainer/LineEdit
@onready var player: CheckButton = $LevelSettings/VBoxContainer2/LineEdit
@onready var settings: CheckButton = $LevelSettings/VBoxContainer3/LineEdit
@onready var cages: CheckButton = $LevelSettings/VBoxContainer4/LineEdit

@onready var add_menu: VBoxContainer = $VBoxContainer
@onready var add_button: Button = $BoxContainer2/BoxContainer/HBoxContainer/Button
@onready var remove_button: Button = $BoxContainer2/BoxContainer/HBoxContainer/Button2
@onready var levelNode: Node2D = $level
@onready var sprite_1: Sprite2D = $Sprite2D
@onready var sprite_2: Sprite2D = $Sprite2D2
@onready var sprite_3: Sprite2D = $Sprite2D3
var new
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	update_output()
func _on_button_pressed() -> void:
	new = sprite_1.duplicate()
	levelNode.add_child(new)
	new.global_position = Vector2(300, 500)
	new.visible = true
	new.name = "0"
func _on_button_add_pressed() -> void:
	$VBoxContainer.visible = not $VBoxContainer.visible
func _on_button_2_pressed() -> void:
	new = sprite_2.duplicate()
	levelNode.add_child(new)
	new.global_position = Vector2(300, 500)
	new.visible = true
	new.name = "0"
func _on_button_3_pressed() -> void:
	new = sprite_3.duplicate()
	levelNode.add_child(new)
	new.global_position = Vector2(300, 500)
	new.visible = true
	new.name = "0"

var outputText:String

func update_output():
	for child in levelNode.get_children():
		if child == null:
			return
		else:
			outputText += "\n \t \" "+ str(child.editor_description)+ "\" "+ ":[[" + str(child.global_position.x)+","+ str(child.global_position.y) + "], 100], "

	
	output.set_text(outputText +"\n },")
	outputText = "\"" + str(level_num.text)+"\"{"
	if player.button_pressed:
		outputText+= "\n\t\"player\": [[0, 25], true]"
	if settings.button_pressed:
		outputText+= "\n\t\"settings\": true"
	if cages.button_pressed:
		outputText+= "\n\t\"cages\": true"
	
	
		
		
	

	
