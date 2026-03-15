extends Node2D

@onready var spawnpoint: Marker2D = $Spawnpoint

@export_file("*.tscn") var destination_scene : String
@export var spawn_offset := 16
@export var door_id : String
@export var destination_door_id : String


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var can_enter_door := true

func _ready():
	DoorManager.register_door(self)

func _on_body_entered(_body: Node2D) -> void:
	
	if not can_enter_door:
		return
	
	can_enter_door = false
	
	DoorManager.next_door_id = destination_door_id
	if destination_scene == "":
		await get_tree().process_frame
		DoorManager.spawn_player()
	else:
		call_deferred("_change_scene")

func _get_exit_offset() -> Vector2:
	var angle =  fmod(rotation_degrees , 360)
	
	if abs(angle) < 10:
		return Vector2(spawn_offset, 0)
	elif abs(angle - 180) < 10:
		return Vector2(-spawn_offset, 0)
	elif abs(angle - 90) < 10:
		return Vector2(0, spawn_offset)
	elif abs(angle - 270) < 10:
		return Vector2(0, -spawn_offset)
	
	return Vector2.ZERO

func _change_scene():
	if destination_scene != "":
		var player = GameManager.player
		if player:
			player.get_parent().remove_child(player)
			get_tree().root.add_child(player)
		get_tree().change_scene_to_file(destination_scene)	
