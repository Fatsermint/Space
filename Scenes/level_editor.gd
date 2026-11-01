extends Node2D

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
	pass


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
