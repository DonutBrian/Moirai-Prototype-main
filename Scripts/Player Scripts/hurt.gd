extends PlayerState

class_name PlayerHurtState

@export var IFRAME_TIME := 0.5
@export var VERTICAL_BOOST := 0.4

func enter():
	super.enter()
	
	var DAMAGE : int = state_machine.PENDING_DAMAGE
	var KNOCKBACK_FORCE : float = state_machine.PENDING_KNOCKBACK_FORCE
	var KNOCKBACK_DIR : Vector2 = state_machine.PENDING_HIT_POSITION
	
	state_machine.PENDING_DAMAGE = 0
	state_machine.PENDING_KNOCKBACK_FORCE = 0.0
	
	player.start_iframes(IFRAME_TIME)
	
	player.HEALTH_REMAINING -= DAMAGE
	player.HEALTH_REMAINING = max(player.HEALTH_REMAINING, 0)
	
	if KNOCKBACK_FORCE > 0:
		var dir := (player.global_position - KNOCKBACK_DIR).normalized()
		dir.y -= VERTICAL_BOOST
		dir = dir.normalized()
		
		player.velocity = dir * KNOCKBACK_FORCE
	else:
		player.velocity.y = max(player.velocity.y, 200)
	sprite.play("Hurt")
	if sprite.animation_finished.is_connected(_on_hurt_finished):
		sprite.animation_finished.disconnect(_on_hurt_finished)
	
	sprite.animation_finished.connect(_on_hurt_finished, CONNECT_ONE_SHOT)
	
func physics_update(delta):
	player.velocity.y += player.GRAVITY * delta
	player.move_and_slide()
	
func _on_hurt_finished():
	if player.HEALTH_REMAINING <= 0:
		state_machine.change_state("playerdeathstate")
		return
		
	if player.is_on_floor():
		state_machine.change_state("playeridlestate")
	else:
		state_machine.change_state("playerfallstate")
