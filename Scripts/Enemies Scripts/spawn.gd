extends EnemyState

class_name EnemySpawnState

@export var duration := 1

func enter():
	super.enter()
	print("In spawn state")
	sprite.play("Spawn")
	enemy.start_iframes(duration)
	if sprite.animation_finished.is_connected(_on_spawn_finished):
		sprite.animation_finished.disconnect(_on_spawn_finished)
	sprite.animation_finished.connect(_on_spawn_finished, CONNECT_ONE_SHOT)
	
func _on_spawn_finished():
	enemy.Hitbox.monitoring = true
	state_machine.change_state("enemyidlestate")
