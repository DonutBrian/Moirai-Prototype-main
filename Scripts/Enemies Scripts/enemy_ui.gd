extends Control

@onready var health_bar: TextureProgressBar = $"VBoxContainer/Health Bar"
@export var fade_time := 1.0
var target_enemy: Node = null
var visible_timer := 0.0

func _process(delta):
	if not target_enemy:
		visible = false
		return
		
	global_position = target_enemy.global_position + Vector2(0, -20)
	
	health_bar.value = target_enemy.HEALTH_REMAINING
	health_bar.max_value = target_enemy.MAXIMUM_HEALTH
	
	if target_enemy.HEALTH_REMAINING >= target_enemy.MAXIMUM_HEALTH:
		visible_timer -= delta
		if visible_timer <= 0:
			visible = false
	
	else:
		visible = true
		visible_timer = fade_time
