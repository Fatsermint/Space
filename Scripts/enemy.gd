extends Sprite2D
@onready var healthBar: ProgressBar = $health


func _process(delta: float) -> void:
	if not $AnimationPlayer.current_animation == "explosion":
		self.position.y += GlobalVariables.enemyInfo[self.editor_description].speed *delta *60
	if self.position.y > -10:
		succes(1)
func _on_area_2d_area_entered(area: Area2D) -> void:

	
	if area.get_parent().is_in_group("bullets"):
		var type = self.editor_description
		var bulletType:String = area.get_parent().name
		print("Bullet type ", bulletType)
		area.get_parent().queue_free()
		if (healthBar.value - (GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal) < 0:
			healthBar.value = 0
		else:
			healthBar.value -= (GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal
			
		if not $AnimationPlayer.current_animation == "explosion":
			showDamage((GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal, [area.global_position.x, area.global_position.y], [self.global_position.x, self.global_position.y])

		
		
		
		if healthBar.value == 0:
			$AnimationPlayer.play("explosion")
			
	
	
	
func succes(value):
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func showDamage(value, location, location2):
	var label = $Label.duplicate()
	add_child(label)
	label.text = str(value)
	print(location)
	label.position = Vector2(location[0] - location2[0] +88, location[1] - location2[1] - 50)
	var tween = create_tween()
	tween.tween_property(label, "position:y", label.position.y -60, 1)
	tween.tween_callback(label.queue_free)
	
	
	
func _on_animation_player_animation_finished(explosion) -> void:
	self.queue_free()
