extends PlayerState

class_name PlayerAttackState

func enter():
	super.enter()
	
	sprite.play("Attack")
	
	player.velocity.x = 0
	
	if player.velocity.y < 0:
		player.velocity.y = 0
	
	player.attack_hitbox.position.y = 5.5
	
	if sprite.flip_h:
		player.attack_hitbox.position.x = -23.5
		
	else:
		player.attack_hitbox.position.x = 0.5
	

	
	player.attack_hitbox.monitoring = true
	
func physics_update(delta):
	player.velocity.x = 0
	
	if not player.is_on_floor():
		player.velocity.y += player.GRAVITY * delta
	
	player.move_and_slide()
	
	if not sprite.is_playing():
		
		var direction = Input.get_axis("Move Left", "Move Right")
		if direction != 0:
			state_machine.change_state("playerwalkstate")
			
		elif not player.is_on_floor():
			state_machine.change_state("playerfallstate")
			
		else:
			state_machine.change_state("playeridlestate")

func exit():
	player.attack_hitbox.monitoring = false
