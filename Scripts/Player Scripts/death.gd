extends PlayerState

class_name PlayerDeathState

func enter():
	super.enter()
	player.velocity  = Vector2.ZERO
	player.set_physics_process(false)
	sprite.play("Death")
	sprite.animation_finished.connect(_on_hurt_finished, CONNECT_ONE_SHOT)
	
func _on_hurt_finished():
	get_tree().reload_current_scene()
