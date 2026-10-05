extends Sprite2D


func _process(delta: float) -> void:
	self.position.y += 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bullets"):
		print("hit")
	
