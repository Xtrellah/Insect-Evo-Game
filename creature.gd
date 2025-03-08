extends Node

class_name Creature

var baseHealth
var baseDamage

func stats(level):
	var Health = baseHealth + (baseHealth * 0.1 * level)
	var Damage = baseDamage + (baseDamage * 0.1 * level)
	print("Health:", Health, "Damage:", Damage)
