extends StaticBody2D

@export var health := 2   

func take_damage(damage, _knockback_force = 0, _hit_position = Vector2.ZERO):
	health -= damage
	
	if health <= 0:
		break_apart()


func break_apart():
	queue_free()
