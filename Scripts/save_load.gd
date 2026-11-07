extends Node

const dataSaveLocation = "user://Save/SaveFile.json"

var content = {
	"money" : 0,
	"level" : 1,
	"hp" : 1,
}

func save():
	var file = FileAccess.open(dataSaveLocation, FileAccess.WRITE)
	file.store_var(content.duplicate())
	file.close()

func load():
	if FileAccess.file_exists(dataSaveLocation):
		var file = FileAccess.open(dataSaveLocation, FileAccess.READ)
		var data = file.get_var()
		file.close()
		var save_data = data.dublicate()
		content.money = save_data.money
		print(content)
