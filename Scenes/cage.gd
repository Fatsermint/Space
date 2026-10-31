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
		self.texture = load(loot)
		status = "loot"
func pick_random(dictionary:Dictionary):
	var randomKey = dictionary.keys().pick_random()
	return dictionary[randomKey]
