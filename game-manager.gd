extends Node2D

var creature_scene = preload("res://Creature/creature.tscn")

func spawn_creature(creature_name: String, spawn_position: Vector2):  
	var json_data = load_json("res://Creature/creatures.json")
	
	if creature_name in json_data:
		var creature_info = json_data[creature_name]

		if creature_scene == null:
			print("Error: creature_scene is null! Check the path.")
			return

		var creature_instance = creature_scene.instantiate()
		
		creature_instance.creature_name = creature_name
		creature_instance.level = creature_info.get("level", 1)
		creature_instance.health = creature_info.get("health", 100)
		creature_instance.attack_power = creature_info.get("attack_power", 10)
		creature_instance.rarity = creature_info.get("rarity", "Common")
		
		var texture_path = creature_info.get("sprite_texture", "")
		print("Texture path:", texture_path)

		if texture_path != "":
			var texture = load(texture_path)
			if texture:
				print("Texture loaded successfully!")
				var sprite = creature_instance.get_node_or_null("Sprite2D")
				if sprite:
					sprite.texture = texture
				else:
					print("Error: Sprite2D node not found!")
			else:
				print("Error: Failed to load texture:", texture_path)

		creature_instance.visible = true
		creature_instance.scale = Vector2(2, 2)

		creature_instance.position = spawn_position
		print("Creature position set to:", creature_instance.position)
		
		add_child(creature_instance)
		
		print("Spawned creature:", creature_name)
	else:
		print("Error: Creature", creature_name, "not found in JSON!")

func load_json(file_path: String) -> Dictionary:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		return JSON.parse_string(content) if content else {}
	return {}

func _ready():
	var spawn_pos = Vector2(300, 200) 
	print("Spawning at position:", spawn_pos)
	spawn_creature("Scorpion", spawn_pos)
