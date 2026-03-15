extends Node

var next_door_id : String = ""
var doors : Dictionary = {}

func _ready():
	get_tree().scene_changed.connect(_on_scene_changed)

func _on_scene_changed():
	doors.clear()
	await get_tree()
	await get_tree().process_frame
	spawn_player()

func register_door(door):
	doors[door.door_id] = door
	print("Registered door:", door.door_id)

func spawn_player():
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	if next_door_id == "":
		return
	
	var player = GameManager.player
	
	if doors.has(next_door_id):
		var door = doors[next_door_id]
		if door.spawnpoint:
			player.global_position = door.spawnpoint.global_position
			player.velocity = Vector2.ZERO
		else:
			player.global_position = door.global_position._get_exit_offset
		
		door.can_enter_door = false
		await get_tree().create_timer(0.3).timeout
		door.can_enter_door = true
		
	next_door_id = ""
