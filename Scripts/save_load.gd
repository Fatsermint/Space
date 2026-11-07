extends Node

const dataSaveLocation = "user://SaveFile.json"

var content:Dictionary = {
	"hp" : 0,
	"money" : 0,
	"level" : 0,
	"device" : null,
	"fired": 0,
	"destroyed": 0,
	
}

func reload():
	content.hp = GlobalVariables.playerInfo["hp"]
	content.money = GlobalVariables.playerInfo["coins"]
	content.device = GlobalVariables.playerInfo["device"]
	content.level = GlobalVariables.playerInfo["level"]
	content.fired = GlobalVariables.playerInfo["stats"]["fired"]
	content.desroyed = GlobalVariables.playerInfo["stats"]["enemydestroyed"]
	
	
func save():
	await reload()
	var file = FileAccess.open_encrypted_with_pass(dataSaveLocation, FileAccess.WRITE, "928435hf4")
	file.store_var(content.duplicate())
	file.close()

func load():
	if FileAccess.file_exists(dataSaveLocation):
		var file = FileAccess.open_encrypted_with_pass(dataSaveLocation, FileAccess.READ, "928435hf4")
		var data = file.get_var()
		file.close()
		var save_data = data
		content.money = save_data.money
		print(save_data)
