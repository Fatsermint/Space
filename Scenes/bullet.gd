extends Node2D

var damage = 10

func _physics_process(delta: float) -> void:
	self.position.y -= 10	
