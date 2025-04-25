extends Node2D
class_name Creature

var creature_name: String
var level: int
var order: String
var max_health: int
var current_health: int
var attack: int
var defense: int
var speed: int
var moves: Array = []
var sprite_url: String
#var status_effects: Array = []  # NOT USED CURRENTLY

func _init(_name = "Creature", _level = 1, _order = "Neutral"):
	name = _name
	level = _level
	order = _order

	# DEFAULT STATS
	max_health = 30 + level * 2
	current_health = max_health
	attack = 10 + level
	defense = 5 + level
	speed = 5 + level

func take_damage(amount: int):
	current_health = max(current_health - amount, 0)
	print("%s takes %d damage (HP: %d/%d)" % [name, amount, current_health, max_health])

func heal(amount: int):
	current_health = min(current_health + amount, max_health)
	print("%s heals for %d (HP: %d/%d)" % [name, amount, current_health, max_health])

func is_defeated() -> bool:
	return current_health <= 0

#func apply_status(effect: String):
	#if effect not in status_effects:
		#status_effects.append(effect)
		#print("%s is now affected by %s." % [name, effect])

#func clear_status():
	#status_effects.clear()
	#print("%s has no more status effects." % name)

func use_move(index: int, target: Creature) -> int:
	if index < 0 or index >= moves.size():
		print("Invalid move index!")
		return 0

	var move = moves[index]
	var damage = move.calculate_damage(self, target)
	print("%s uses %s on %s!" % [name, move.name, target.name])
	target.take_damage(damage)
	return damage
