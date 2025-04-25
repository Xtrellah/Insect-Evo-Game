extends Creature
class_name Mantodea

func _init(name := "Unnamed Mantodea", level := 1):
	super(name, level, "Mantodea")

	max_health = 100 + level * 2
	current_health = max_health
	attack = 40 + level * 1.5
	defense = 20 + level / 2
	speed = 30 + level

	# MANTODEA MOVESET
	var raptorialslash = Move.new()
	raptorialslash.name = "Raptorial Slash"
	raptorialslash.power = 3
	raptorialslash.order = "Mantodea"

	var stealthstrike = Move.new()
	stealthstrike.name = "Stealth Strike"
	stealthstrike.power = 2
	stealthstrike.order = "Mantodea"

	moves = [stealthstrike, raptorialslash]
