extends EnemyState

class_name EnemyDeathState

func enter():
	super.enter()
	
	sprite.play("Death")
	if sprite.animation_finished.is_connected(_on_death_finished):
		sprite.animation_finished.disconnect(_on_death_finished)
	
	sprite.animation_finished.connect(_on_death_finished, CONNECT_ONE_SHOT)
	
func _on_death_finished():
	enemy.queue_free()
	
