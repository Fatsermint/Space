extends Label



func _process(delta: float) -> void:
	self.text = str(GlobalVariables.playerInfo["coins"])
	$"../../VBoxContainer2/Label".text = str(GlobalVariables.playerInfo["hp"])
