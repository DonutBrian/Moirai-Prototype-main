extends EnemyState

class_name EnemyIdleState

func enter():
	super.enter()
	sprite.play("Idle")
	
	if not enemy.is_on_floor():
		state_machine.change_state("enemyfallstate")

	
