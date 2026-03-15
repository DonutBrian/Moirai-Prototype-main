extends PlayerState

class_name PlayerDashState

@export var IFRAME_TIME := 0.5

var dash_direction: float = 1.0
var dash_timer : float = 0.0

func enter():
	super.enter()
	
	if player.DASHES_REMAINING <= 0:
		if player.is_on_floor():
			state_machine.change_state("playeridlestate")
		else:
			state_machine.change_state("playerfallstate")
		return

	player.DASHES_REMAINING -= 1
	sprite.play("Dash")
	
	dash_timer = player.DASH_TIME
	
	player.start_iframes(IFRAME_TIME)

	var direction = Input.get_axis("Move Left","Move Right")
	if direction != 0:
		dash_direction = direction
	else: 
		if sprite.flip_h:
			dash_direction = -1
		else:
			dash_direction = 1

func physics_update(delta: float) -> void:
	player = state_machine.get_parent()
	
	player.velocity.x = dash_direction * player.DASH_SPEED
	player.velocity.y = 0 
	
	player.move_and_slide()
	
	dash_timer -= delta
	
	if dash_timer <= 0:
		if not player.is_on_floor():
			state_machine.change_state("playerfallstate")
		elif Input.is_action_pressed("Move Left") or Input.is_action_just_pressed("Move Right"):
			state_machine.change_state(("playerwalkstate"))
		else:
			state_machine.change_state("playeridlestate")
			
	
	
