extends PlayerAirState

class_name PlayerFallState

func enter():
	super.enter()
	sprite.play("Fall")
	
func physics_update(delta):
	super.physics_update(delta)
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 0:
			state_machine.change_state("playerwalkstate")
		else:
			state_machine.change_state("playeridlestate")
