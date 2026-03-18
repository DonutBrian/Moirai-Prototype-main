extends Control

var rebinding_action = null

func _ready():
	update_buttons()

func update_buttons():
	$"Window/VBoxContainer/HBoxContainer/LeftButton".text = get_key_name("Move Left")
	$"Window/VBoxContainer/HBoxContainer2/RightButton".text = get_key_name("Move Right")
	$Window/VBoxContainer/HBoxContainer3/JumpButton.text = get_key_name("Jump")
	$Window/VBoxContainer/HBoxContainer4/DashButton.text = get_key_name("Dash")
	$Window/VBoxContainer/HBoxContainer5/AttackButton.text = get_key_name("Attack")
	$Window/VBoxContainer/HBoxContainer6/SaveButton.text = get_key_name("Save")
	$Window/VBoxContainer/HBoxContainer7/InteractButton.text = get_key_name("Interact")
	$Window/VBoxContainer/HBoxContainer8/MenuButton.text = get_key_name("Menu")
	
func get_key_name(action):
	
	var events = InputMap.action_get_events(action)
	
	if events.size() > 0:
		var event = events[0]
		
		if event is InputEventKey:
			return OS.get_keycode_string(event.keycode)
		
		if event is InputEventMouseButton:
			return "Mouse" + str(event.button_index)
	
	return "None"

func _on_left_button_pressed() -> void:
	start_rebind("Move Left")


func _on_right_button_pressed() -> void:
	start_rebind("Move Right")


func _on_jump_button_pressed() -> void:
	start_rebind("Jump")


func _on_dash_button_pressed() -> void:
	start_rebind("Dash")


func _on_attack_button_pressed() -> void:
	start_rebind("Attack")


func _on_save_button_pressed() -> void:
	start_rebind("Save")


func _on_interact_button_pressed() -> void:
	start_rebind("Interact")


func _on_menu_button_pressed() -> void:
	start_rebind("Menu")

func start_rebind(action):
	rebinding_action = action
	print("Press a key for", action)
	
func _input(event):
	if rebinding_action == null:
		return
	
	if event is InputEventKey and event.pressed:
		InputMap.action_erase_events(rebinding_action)
		var new_event = InputEventKey.new()
		new_event.keycode = event.keycode
		InputMap.action_add_event(rebinding_action, new_event)
		
		rebinding_action = null
		update_buttons()
d
func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/settings_menu.tscn")
