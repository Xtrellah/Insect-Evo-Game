extends Node2D

class_name Creature

@export var creature_name: String = "Unknown"
@export var level: int = 1
@export var health: int = 100
@export var attack_power: int = 10
@export var rarity: String = "Common"
@export var sprite_texture: Texture2D

func _ready():
	load_creature_data(creature_name)

func load_creature_data(creature_name_param: String):
	var json_data = load_json("res://creatures.json")
	
	if creature_name_param in json_data:
		var creature_info = json_data[creature_name_param]
		level = creature_info.get("level", level)
		health = creature_info.get("health", health)
		attack_power = creature_info.get("attack_power", attack_power)
		rarity = creature_info.get("rarity", rarity)

		var texture_path = creature_info.get("sprite_texture", "")
		if texture_path != "":
			var texture = load(texture_path)
			if texture and $Sprite2D:
				$Sprite2D.texture = texture

func load_json(file_path: String) -> Dictionary:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if content else {}
	return {}
