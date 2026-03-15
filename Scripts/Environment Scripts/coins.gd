extends Area2D
class_name Coin

@export var VALUE := 0
@export var MAGNET_RANGE := 64
@export var MAGNET_SPEED := 50
@export var RESPAWNABLE := false	

@onready var COIN_ID = "%s_%s" % [
		get_tree().current_scene.name,
		str(global_position)
	]
func _ready():

	if Global.COLLECTED_COINS.has(COIN_ID):
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
		
func collect(_player: Player):
	if not RESPAWNABLE:
		if Global.COLLECTED_COINS.has(COIN_ID):
			return
		Global.COLLECTED_COINS[COIN_ID] = true
	Global.MONEY += 1
	print("collected money so far:", Global.COLLECTED_COINS)
	queue_free()
