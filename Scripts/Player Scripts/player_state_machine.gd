extends BaseStateMachine

class_name PlayerStateMachine

var PENDING_DAMAGE := 0
var PENDING_KNOCKBACK_FORCE := 0.0
var PENDING_HIT_POSITION := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
