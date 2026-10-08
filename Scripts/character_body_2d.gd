extends CharacterBody2D

var speed: float = 100
var timesFired = 2
var bullet = preload("res://Scenes/bullet.tscn").instantiate()

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction* speed
	
	if Input.is_action_just_pressed("fire"):
		timesFired += 1
		var bul = bullet.duplicate()
		bul.name = "bullet"
		print(self.get_parent().get_children(), "  bob")
		self.get_parent().find_child("bullets").add_child(bul)
		
		if timesFired % 2 !=0:
			bul.position.x = self.position.x -12
			bul.position.y = 0 -8
		else:
			bul.position.x = self.position.x + 12
			bul.position.y = 0 -8
		
		
	
	
	move_and_slide()

	
