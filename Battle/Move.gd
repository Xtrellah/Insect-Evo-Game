class_name Move
extends Resource

var name: String
var power: int
var order: String

func calculate_damage(attacker: Creature, defender: Creature) -> int:
	var base = attacker.attack - defender.defense
	base = max(base, 1)
	var multiplier = TypeChart.get_effectiveness(order, defender.order)
	return int(base * power * multiplier)
