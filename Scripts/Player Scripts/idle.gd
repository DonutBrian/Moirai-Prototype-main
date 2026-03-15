extends PlayerState

class_name PlayerIdleState

func enter():
	super.enter()
	sprite.play("Idle")
	if character.is_on_floor():
		player.JUMPS_REMAINING = player.MAX_JUMPS
		player.DASHES_REMAINING = player.MAX_DASHES
	pass

func handle_input(_event: InputEvent):
	if Input.is_action_pressed("Move Left") or Input.is_action_pressed("Move Right"):
		state_machine.change_state("playerwalkstate")
		
	elif Input.is_action_just_pressed("Jump") and character.is_on_floor():
		state_machine.change_state("playerjumpstate")
	
	elif not character.is_on_floor():
		state_machine.change_state("playerfallstate")

	elif Input.is_action_just_pressed("Dash"):
		state_machine.change_state("playerdashstate")
	
	elif Input.is_action_just_pressed("Attack"):
		state_machine.change_state("playerattackstate")
	
