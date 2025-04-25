extends Node
class_name TypeChart

static var effectiveness = {
	"Hymenoptera": {
		"Araneae": 1.5,
		"Mantodea": 0.5,
		"Hymenoptera": 1.0
	},
	"Mantodea": {
		"Hymenoptera": 1.5,
		"Araneae": 0.5,
		"Mantodea": 1.0
	},
	"Araneae": {
		"Mantodea": 1.5,
		"Hymenoptera": 0.5,
		"Araneae": 1.0
	}
}

static func get_effectiveness(attacker_type: String, defender_type: String) -> float:
	if effectiveness.has(attacker_type) and effectiveness[attacker_type].has(defender_type):
		return effectiveness[attacker_type][defender_type]
	return 1.0
