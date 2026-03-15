extends PlayerState

class_name PlayerAirState

@export var AIR_CONTROL_SPEED := 200

func physics_update(delta):
	
	if player.is_on_floor() and player.velocity.y >= 0:
		if abs(player.velocity.x) > 0:
			state_machine.change_state("playerwalkstate")
		else:
			state_machine.change_state("playeridlestate")
		return
	
	player.velocity.y += player.GRAVITY * delta
	
	var direction = Input.get_axis("Move Left","Move Right")
	player.velocity.x = direction * AIR_CONTROL_SPEED
	
	if direction != 0:
		sprite.flip_h = direction < 0

	if Input.is_action_just_pressed("Jump") and player.JUMPS_REMAINING > 0:
		player.JUMPS_REMAINING -= 1
		state_machine.change_state("playerjumpstate")
		return
		
	if Input.is_action_just_pressed("Dash") and player.DASHES_REMAINING > 0:
		state_machine.change_state("playerdashstate")
		return
		
	if Input.is_action_just_pressed("Attack"):
		state_machine.change_state("playerattackstate")
		return
	
	player.move_and_slide()
