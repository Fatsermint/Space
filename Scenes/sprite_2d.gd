extends Sprite2D
var selected = false
var dragging = false
var state = null
var of = Vector2(0,0)
@onready var check_button: CheckButton = $"../BoxContainer2/BoxContainer/HBoxContainer/CheckButton"

var snap:float =50
var snapping

func _process(delta: float) -> void:
	
	if state=="drag":
		var NewPos = get_global_mouse_position() - of
		if snapping == true:
			global_position = Vector2(snapped(NewPos.x, snap), snapped(NewPos.y, snap))
			print("a")
		else:
			global_position = NewPos
		





func next_state():
	if state == null:
		state = "selected"
		return
	elif state == "selected":
		state = "drag"
		return
	elif state == "drag":
		state = null
func _on_button_toggled(toggled_on: bool) -> void:
	
	

	if state == "drag":
		of = get_global_mouse_position()- global_position
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false
		


func _on_check_button_toggled(toggled_on: bool) -> void:
	snapping = toggled_on
	print(toggled_on)


func _on_button_pressed() -> void:
	next_state()
	print(state)
