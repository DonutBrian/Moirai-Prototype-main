extends PlayerAirState

class_name PlayerJumpState

func enter():
	super.enter()
	sprite.play("Jump")

	player.velocity.y = player.JUMP_SPEED
	
func physics_update(delta):
	super.physics_update(delta)
	
	if player.velocity.y > 0:
		state_machine.change_state("playerfallstate")
