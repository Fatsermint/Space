extends Sprite2D
@onready var healthBar: ProgressBar = $health

var hp = 100
func _process(delta: float) -> void:
	self.position.y += 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bullets"):
		print("hit")
		if (healthBar.value - GlobalVariables.bulletDamages[0]) < 0:
			healthBar.value = 0
		else:
			
			healthBar.value -= GlobalVariables.bulletDamages[0]
		if healthBar.value == 0:
			print("a")
			$AnimationPlayer.play("explosion")
			
	


func _on_animation_player_animation_finished(explosion) -> void:
	self.queue_free()
