extends EnemyState

class_name EnemyFallState

func enter():
	super.enter()

	
func physics_update(delta):
	
	enemy.velocity.y += enemy.GRAVITY * delta
	var direction = Input.get_axis("Move Left","Move Right")
	enemy.velocity.x = direction * 200
	if direction != 0:
		sprite.flip_h = direction < 0
		
	enemy.move_and_slide()
	if enemy.is_on_floor():
		if direction != 0:
			state_machine.change_state("enemywalkstate")
		else:
			state_machine.change_state("enemyidlestate")
