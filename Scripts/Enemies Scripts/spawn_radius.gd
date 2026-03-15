extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("someones here")
	if body is Player:
		var enemy := get_parent() as Enemy
		var state_machine := enemy.get_node("StateMachine") as EnemyStateMachine
		var sprite := enemy.get_node("AnimatedSprite2D") as AnimatedSprite2D
		
		if body.global_position.x < enemy.global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
		state_machine.change_state("enemyspawnstate")
		
		set_deferred("monitoring", false)
		$CollisionShape2D.set_deferred("disabled", true)
		
