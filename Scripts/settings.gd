extends CanvasLayer

@onready var fpsLabel: Label = $Label





func _on_check_button_pressed() -> void:
	print("impoertat")
	showFps($VBoxContainer/HBoxContainer/CheckButton.button_pressed)
func _process(delta: float) -> void:
	fpsLabel.text = str(Engine.get_frames_per_second())
	fpsLabel.text += " fps"
	
func showFps(value):
	fpsLabel.visible = value


func _on_check_button_pressed_limited_fps() -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
