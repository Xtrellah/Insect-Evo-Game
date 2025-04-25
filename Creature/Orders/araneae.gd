extends Creature
class_name Araneae

func _init(name := "Unnamed Araneae", level := 1):
	super(name, level, "Araneae")

	max_health = 90 + level * 2
	current_health = max_health
	attack = 30 + level
	defense = 25 + level / 2
	speed = 28 + level

	# ARANEAE MOVESET
	var piercingfangs = Move.new()
	piercingfangs.name = "Piercing Fangs"
	piercingfangs.power = 3
	piercingfangs.order = "Araneae"
	# poison maybe

	var webtrap = Move.new()
	webtrap.name = "Web Trap"
	webtrap.power = 1
	webtrap.order = "Araneae"
	# status effect at some point

	moves = [piercingfangs, webtrap]
