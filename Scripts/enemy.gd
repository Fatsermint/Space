extends Sprite2D
@onready var healthBar: ProgressBar = $health
signal summonNewEnemies
var type
func _process(delta: float) -> void:
	var freeze = 100
	if GlobalVariables.playerInfo["effects"].has("freeze"):
		freeze = GlobalVariables.playerInfo["effects"]["freeze"]["freeze"]
		print(freeze, "freeze")
	if not $AnimationPlayer.current_animation == "explosion":
		self.position.y += GlobalVariables.enemyInfo[self.editor_description].speed *delta *60 * (freeze*0.01)
	if self.position.y > -10:
		succes()
	if freeze < 100:
		$Sprite2D2.visible = true
	else:
		$Sprite2D2.visible = false
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bullets"):
		type = self.editor_description
		var bulletType:String = area.get_parent().name
		area.get_parent().queue_free()
		if (healthBar.value - (GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal) < 0:
			healthBar.value = 0
			
		else:
			healthBar.value -= (GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal
			
		if not $AnimationPlayer.current_animation == "explosion":
			showDamage((GlobalVariables.bulletDamages[0] * GlobalVariables.enemyInfo[type].shield["%"])-GlobalVariables.enemyInfo[type].shield.normal, [area.global_position.x, area.global_position.y], [self.global_position.x, self.global_position.y])
		
		
		
		if healthBar.value == 0:
			if self.is_in_group("newChild") and GlobalVariables.enemyInfo[type]["child"]["status"] == "alive":
				get_parent().newEnemy([global_position.x,global_position.y], GlobalVariables.enemyInfo[type]["child"]["type"], type)
				GlobalVariables.enemyInfo[type]["child"]["status"] = "dead"
				
			
			GlobalVariables.playerInfo.stats.enemydestroyed += 1

			$AnimationPlayer.play("explosion")
			
	
	
	
func succes():
	GlobalVariables.playerInfo.hp -= healthBar.value *0.5
	self.queue_free()

func showDamage(value, location, location2):
	var label = $Label.duplicate()
	add_child(label)
	label.text = str(value)
	label.position = Vector2(location[0] - location2[0] +88, location[1] - location2[1] - 50)
	var tween = create_tween()
	tween.tween_property(label, "position:y", label.position.y -60, 1)
	tween.tween_callback(label.queue_free)
	
	
	
func _on_animation_player_animation_finished(explosion) -> void:
	get_parent().check_end_level(self)
	print(GlobalVariables.playerInfo["effects"], "THIS ONE")
	if GlobalVariables.playerInfo["effects"].has("coinEffect") == true: 
	
	
		GlobalVariables.playerInfo.coins += GlobalVariables.enemyInfo[type].value * GlobalVariables.playerInfo["effects"]["coinEffect"]["coinEffect"]
	else:
		GlobalVariables.playerInfo.coins += GlobalVariables.enemyInfo[type].value 
	
	self.queue_free()
