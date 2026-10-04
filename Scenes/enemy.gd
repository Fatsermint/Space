extends CharacterBody2D



func _process(delta: float) -> void:
	self.position.y += 1
	if self.touched==true:
		print("a")
