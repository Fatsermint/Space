extends Label



func _process(delta: float) -> void:
	self.text = str(GlobalVariables.playerInfo["coins"])
	print(self.global_position, "label pos")
