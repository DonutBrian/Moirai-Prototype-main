extends EnemyState

class_name EnemyHiddenState

func enter():
	super.enter()
	print("Enter Hidden State")
	
	sprite.play("Hidden")
	enemy.velocity = Vector2.ZERO
	enemy.set_physics_process(false)

func exit():
	enemy.set_physics_process(true)
