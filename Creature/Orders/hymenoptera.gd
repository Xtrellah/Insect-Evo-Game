extends Creature
class_name Hymenoptera

func _init(name := "Unnamed Hymenoptera", level := 1):
	super(name, level, "Hymenoptera")

	max_health = 95 + level * 2
	current_health = max_health
	attack = 35 + level
	defense = 20 + level / 2
	speed = 32 + level

	# HYMENOPTERA MOVESET
	var sting = Move.new()
	sting.name = "Sting"
	sting.power = 2
	sting.order = "Hymenoptera"

	var buzz = Move.new()
	buzz.name = "Buzz"
	buzz.power = 1
	buzz.order = "Hymenoptera"

	moves = [sting, buzz]
