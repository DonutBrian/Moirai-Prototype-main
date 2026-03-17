extends Area2D
class_name Pickup

@export var MAGNET_RANGE := 64
@export var MAGNET_SPEED := 50
@export var RESPAWNABLE := false	

var pickup_id: String

func _ready():
	pickup_id = "%s_%s" % [
		get_tree().current_scene.name,
		str(global_position)
	]
	
	if not RESPAWNABLE and is_collected():
		queue_free()
func _physics_process(delta):
	if MAGNET_RANGE <= 0:
		return
	
	var player := get_tree().get_first_node_in_group("player")
	if player and global_position.distance_to(player.global_position) <= MAGNET_RANGE:
		global_position = global_position.move_toward(
			player.global_position,
			MAGNET_SPEED * delta
		)
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collect(body)
		
func collect(player: Player):
	if not RESPAWNABLE:
		if is_collected():
			return
		mark_collected()
	apply_effect(player)
	queue_free()

func apply_effect(_player):
	pass

func is_collected():
	return Global.COLLECTED_COINS.has(pickup_id)

func mark_collected():
	Global.COLLECTED_COINS[pickup_id] = true
