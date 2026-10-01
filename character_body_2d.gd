extends CharacterBody2D

var speed: float = 100

var bullet = preload("res://Scenes/bullet.tscn").instantiate()

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction* speed
	
	if Input.is_action_just_pressed("fire"):
		var bul = bullet.duplicate()
		bul.name = "bullet"
		self.add_child(bul)
		print(bul)
	
	move_and_slide()

	
