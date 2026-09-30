extends CharacterBody2D

var gas = 0.5



func _physics_process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		gas += 2 *delta
		if gas > 10:
			gas = 10
		print(gas)
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		gas -= 2 *delta
		if gas < 0.5:
			gas = 0.5
		print(gas)
		
	
	look_at(get_global_mouse_position())
	
	var vel:Vector2 = (get_global_mouse_position() - global_position)
	
	velocity = vel * gas
	move_and_slide()
