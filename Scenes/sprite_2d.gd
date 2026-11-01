extends Sprite2D

var dragging = false
var of = Vector2(0,0)
@onready var check_button: CheckButton = $"../BoxContainer2/BoxContainer/HBoxContainer/CheckButton"

var snap:float =50
var snapping

func _process(delta: float) -> void:
	
	if dragging:
		var NewPos = get_global_mouse_position() - of
		if snapping == true:
			global_position = Vector2(snapped(NewPos.x, snap), snapped(NewPos.y, snap))
			print("a")
		else:
			global_position = NewPos
		






func _on_button_toggled(toggled_on: bool) -> void:
	dragging = toggled_on
	if dragging:
		of = get_global_mouse_position()- global_position
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false
		


func _on_check_button_toggled(toggled_on: bool) -> void:
	snapping = toggled_on
	print(toggled_on)
