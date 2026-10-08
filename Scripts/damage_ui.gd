extends CanvasLayer

signal addToMainScene

func show_damage(value, position):
	print("damage popup ", value, " ", position)
	addToMainScene.emit()
	
