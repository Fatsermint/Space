extends CanvasLayer


@onready var failedContainer: HBoxContainer = $HBoxContainer


func _on_button_start_game_pressed() -> void:
	set_stats_back()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_tutorial_pressed() -> void:
	$ColorRect2.visible = true


func _on_button_settings_pressed() -> void:
	$ColorRect.visible = true


func _on_button_settings_escape_pressed() -> void:
	$ColorRect.visible = false

func _process(delta: float) -> void:
	if GlobalVariables.playerInfo["level"]>=1:
		print("failed at level", GlobalVariables.playerInfo["level"])
		failedContainer.visible = true
		$HBoxContainer/Label.text = "You failed at level "+str(GlobalVariables.playerInfo["level"])
		await get_tree().create_timer(5).timeout
		failedContainer.visible = false
		

func set_stats_back():
	GlobalVariables.playerInfo["level"] = 0


func _on_button_tutorial_escape_pressed() -> void:
	$ColorRect2.visible = false 
