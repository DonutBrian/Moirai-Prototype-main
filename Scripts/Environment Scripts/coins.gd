extends Pickup
class_name Coin

@export var VALUE := 1

func apply_effect(_player):
	Global.MONEY += VALUE
	print("money:", Global.MONEY)
