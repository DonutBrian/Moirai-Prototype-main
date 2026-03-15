extends Area2D
class_name DamageZone

@export var DAMAGE := 0
@export var KNOCKBACK_FORCE := 0.0
@export var ONE_SHOT := false

func _on_body_entered(body: Node2D) -> void:
	var state_machine := body.get_node_or_null("StateMachine")
	if state_machine == null:
		return
		
	if not state_machine is BaseStateMachine:
		return
		
	if body.IS_INVINCIBLE:
		return
		
	state_machine.PENDING_DAMAGE = DAMAGE
	state_machine.PENDING_KNOCKBACK_FORCE = KNOCKBACK_FORCE
	state_machine.PENDING_HIT_POSITION = global_position
	if body is Player:
		if ONE_SHOT:
			state_machine.change_state("playerdeathstate")
		
		else:
			state_machine.change_state("playerhurtstate")
	
		
