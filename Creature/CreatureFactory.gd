extends Node
class_name CreatureFactory

var creature_data = {}

func _ready():
	load_creature_data("res://Creature/creatures.json")


func load_creature_data(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		creature_data = JSON.parse_string(text)


func load_creature_by_name(creature_name: String) -> Creature:
	var data = creature_data.get(creature_name)
	if data == null:
		push_error("Creature not found: %s" % creature_name)
		return null

	var creature_class = get_class_by_order(data["order"])
	if creature_class == null:
		push_error("Unknown order type: %s" % data["order"])
		return null

	var creature = creature_class.new()
	creature.creature_name = creature_name
	creature.level = data["level"]
	creature.order = data["order"]
	creature.max_health = data["max_health"]
	creature.current_health = data["max_health"]
	creature.attack = data["attack"]
	creature.defense = data["defense"]
	creature.speed = data["speed"]
	creature.sprite_url = data["sprite_url"]

	# LOAD SPRITE
	var sprite = Sprite2D.new()
	sprite.texture = load(data["sprite_url"])
	creature.add_child(sprite)

	# ADD MOVES
	var move_list = []
	for move_data in data["moves"]:
		var move = Move.new()
		move.name = move_data["name"]
		move.power = move_data["power"]
		move.order = move_data["order"]
		move_list.append(move)
	creature.moves = move_list

	return creature


func get_class_by_order(order: String):
	match order:
		"Hymenoptera":
			return Hymenoptera
		"Mantodea":
			return Mantodea
		"Araneae":
			return Araneae
		_:
			return null
