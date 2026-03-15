extends EnemyState

class_name EnemyHurtState

@export var IFRAME_TIME := 0.3
@export var VERTICAL_BOOST := 0.4

func enter():
	super.enter()
	print("Ow")
	var DAMAGE : int = state_machine.PENDING_DAMAGE
	var KNOCKBACK_FORCE : float = state_machine.PENDING_KNOCKBACK_FORCE
	var HIT_POS : Vector2 = state_machine.PENDING_HIT_POSITION
	
	state_machine.PENDING_DAMAGE = 0
	state_machine.PENDING_KNOCKBACK_FORCE = 0.0
	
	enemy.start_iframes(IFRAME_TIME)
	
	enemy.HEALTH_REMAINING -= DAMAGE
	enemy.HEALTH_REMAINING = max(enemy.HEALTH_REMAINING, 0)
	
	if KNOCKBACK_FORCE > 0:
		var horizontal_dir := (enemy.global_position.x - HIT_POS.x)
		enemy.velocity.x = horizontal_dir * KNOCKBACK_FORCE
		enemy.velocity.y = -VERTICAL_BOOST * KNOCKBACK_FORCE
	else:
		enemy.velocity.y = max(enemy.velocity.y, 200)
	
	if enemy.HEALTH_REMAINING <= 0:
		state_machine.change_state("enemydeathstate")
		return
		
	sprite.play("Hurt")
	
	if sprite.animation_finished.is_connected(_on_hurt_finished):
		sprite.animation_finished.disconnect(_on_hurt_finished)
	
	sprite.animation_finished.connect(_on_hurt_finished, CONNECT_ONE_SHOT)
	
func physics_update(delta):
	enemy.velocity.y += enemy.GRAVITY * delta
	enemy.move_and_slide()

func _on_hurt_finished():
	state_machine.change_state("enemyidlestate")
