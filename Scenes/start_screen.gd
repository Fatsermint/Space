extends CanvasLayer




func _on_button_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_tutorial_pressed() -> void:
	pass # Replace with function body.


func _on_button_settings_pressed() -> void:
	$ColorRect.visible = true


func _on_button_settings_escape_pressed() -> void:
	$ColorRect.visible = false
