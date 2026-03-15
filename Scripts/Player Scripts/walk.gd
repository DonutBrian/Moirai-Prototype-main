extends PlayerState

class_name PlayerWalkState

func enter():
	super.enter()
	sprite.play("Move")


func physics_update(_delta):

	var direction = Input.get_axis("Move Left","Move Right")
	
	if not player.is_on_floor():
		state_machine.change_state("playerfallstate")
		return
		
	elif player.is_on_floor():
		player.JUMPS_REMAINING = player.MAX_JUMPS
		player.DASHES_REMAINING = player.MAX_DASHES
		
	if not (Input.is_action_pressed("Move Left") or Input.is_action_pressed("Move Right")):
		state_machine.change_state("playeridlestate")
		return

	if direction != 0:
		sprite.flip_h = direction < 0
	player.velocity.x = direction * player.WALK_SPEED
	player.move_and_slide()
	
func handle_input(_event):
	if Input.is_action_just_pressed("Jump"):
		state_machine.change_state("playerjumpstate")
		
	elif Input.is_action_pressed("Dash") and player.DASHES_REMAINING > 0:
		state_machine.change_state("playerdashstate")
		
	elif Input.is_action_just_pressed("Attack"):
		state_machine.change_state("playerattackstate")
