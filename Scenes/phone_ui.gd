extends CanvasLayer
@onready var right: TextureButton = $HBoxContainer2/ColorRect/TextureButton

@onready var left: TextureButton = $HBoxContainer/ColorRect/TextureButton
@onready var shoot: Button = $HBoxContainer3/ColorRect/Button

func _process(delta: float) -> void:
	pass
func _shoot_bullet():
	Input.action_press("fire")
	
	Input.action_release("fire")
	

func move_left():
	Input.action_press("left")
func move_right():
	Input.action_press("right")

func stop():
	Input.action_release("left")
	Input.action_release("right")
	
func _on_texture_button_pressed() -> void:
	move_right()


func _on_button_pressed() -> void:
	print("how")
	_shoot_bullet()


func _on_texture_button_button_down() -> void:
	move_right()
	


func _on_texture_button_button_up() -> void:
	stop()


func _on_texture_button_button_down_left() -> void:
	move_left()
