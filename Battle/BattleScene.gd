extends Node2D

@onready var player_spawn := $PlayerSpawn
@onready var enemy_spawn := $EnemySpawn

@onready var player_name_label := $PlayerUI/CreatureName
@onready var player_hp_bar := $PlayerUI/HealthBar
@onready var player_moves_panel := $PlayerUI/MovesPanel

@onready var enemy_name_label := $EnemyUI/CreatureName
@onready var enemy_hp_bar := $EnemyUI/HealthBar

var player_creature: Creature
var enemy_creature: Creature

func _ready():
	var factory = CreatureFactory.new()
	factory._ready()

	player_creature = factory.load_creature_by_name("Orchid Mantis")
	enemy_creature = factory.load_creature_by_name("Vulture Bee")

	if player_creature:
		add_child(player_creature)
		player_creature.global_position = player_spawn.global_position

	if enemy_creature:
		add_child(enemy_creature)
		enemy_creature.global_position = enemy_spawn.global_position
		enemy_creature.scale.x = -1

	player_name_label.text = player_creature.creature_name
	player_hp_bar.max_value = player_creature.max_health
	player_hp_bar.value = player_creature.current_health

	enemy_name_label.text = enemy_creature.creature_name
	enemy_hp_bar.max_value = enemy_creature.max_health
	enemy_hp_bar.value = enemy_creature.current_health

	generate_move_buttons()
	start_battle()

func generate_move_buttons():
	for child in player_moves_panel.get_children():
		child.queue_free()

	for move in player_creature.moves:
		var button := Button.new()
		button.text = move.name
		button.pressed.connect(_on_move_button_pressed.bind(move))
		player_moves_panel.add_child(button)


func start_battle():
	print("--- BATTLE START ---")
	await get_tree().create_timer(1.0).timeout
	take_turn()


func _on_move_button_pressed(move: Move):
	for child in player_moves_panel.get_children():
		child.disabled = true

	await process_player_turn(move)


func process_player_turn(player_move: Move):
	print("%s uses %s!" % [player_creature.creature_name, player_move.name])
	var damage = calculate_damage(player_creature, enemy_creature, player_move)
	enemy_creature.current_health -= damage
	print("Enemy takes %d damage (HP: %d)" % [damage, enemy_creature.current_health])
	update_health_bars()

	await get_tree().create_timer(1.0).timeout

	if enemy_creature.current_health <= 0:
		print("Enemy fainted! You win!")
		return

	await enemy_turn()


func enemy_turn():
	var enemy_move = enemy_creature.moves[0]
	print("%s uses %s!" % [enemy_creature.creature_name, enemy_move.name])
	var damage = calculate_damage(enemy_creature, player_creature, enemy_move)
	player_creature.current_health -= damage
	print("You take %d damage (HP: %d)" % [damage, player_creature.current_health])
	update_health_bars()

	await get_tree().create_timer(1.0).timeout

	if player_creature.current_health <= 0:
		print("You fainted! Game over.")
		return

	take_turn()


func update_health_bars():
	player_hp_bar.value = player_creature.current_health
	enemy_hp_bar.value = enemy_creature.current_health


func take_turn():
	print("Your turn. Choose a move.")
	for child in player_moves_panel.get_children():
		child.disabled = false


func calculate_damage(attacker: Creature, defender: Creature, move: Move) -> int:
	var base_damage = move.power * attacker.attack / 10
	var multiplier := 1.0
	if is_strong_against(move.order, defender.order):
		multiplier = 1.5
		print("It's super effective!")
	elif is_weak_against(move.order, defender.order):
		multiplier = 0.5
		print("It's not very effective...")

	return int(base_damage * multiplier)

func is_strong_against(attacker_order: String, defender_order: String) -> bool:
	return (attacker_order == "Hymenoptera" and defender_order == "Araneae"
		 or attacker_order == "Mantodea" and defender_order == "Hymenoptera"
		 or attacker_order == "Araneae" and defender_order == "Mantodea")

func is_weak_against(attacker_order: String, defender_order: String) -> bool:
	return is_strong_against(defender_order, attacker_order)
