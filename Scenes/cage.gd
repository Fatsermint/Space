extends Sprite2D

var loot 
var status = "box"
func _ready() -> void:
	loot = pick_random(GlobalVariables.cages["loot"])
func _process(delta: float) -> void:
	if status == "loot":
		self.global_position.y += 1 * delta * 250
		
	self.global_position.y += 1 * delta * 100


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("bullets"):
		print(loot)
		self.texture = load(GlobalVariables.cages["loot"][loot]["path"])
		if status == "box":
			area.get_parent().queue_free()
		status = "loot"
		
func pick_random(dictionary:Dictionary):
	var keys = dictionary.keys()
	while true:
		var randomKey = keys.pick_random()
		
		if GlobalVariables.cages["loot"][randomKey]["effect"]["positive"] == true and not self.editor_description == "bad":
			return randomKey
		elif GlobalVariables.cages["loot"][randomKey]["effect"]["positive"] == false and self.editor_description == "bad":
			return randomKey
	#var randomKey = dictionary.keys().pick_random()
	#if GlobalVariables.cages["loot"][randomKey]["effect"]["positive"] == true and not self.editor_description == "bad":
	#	pass
	#else:
	#	return
	#if GlobalVariables.cages["loot"][randomKey]["effect"]["positive"] == false and self.editor_description == "bad":
	#	pass
	#else:
	#	return
	#	
	#return dictionary["loot"][randomKey]
func get_loot():
	return loot
func get_status():
	return status
