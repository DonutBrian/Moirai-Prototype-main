extends Control
func _ready():
	update_save_buttons()
	
func _on_save_1_pressed() -> void:
	slot_pressed(1)


func _on_save_2_pressed() -> void:
	slot_pressed(2)


func _on_save_3_pressed() -> void:
	slot_pressed(3)


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu/main_menu.tscn")

func update_save_buttons():
	for i in range(1,4):
		
		var path = SaveManager.get_save_path(i)
		var button = get_node("Save Window/VBoxContainer/HBoxContainer/Save%d" % i)
		if FileAccess.file_exists(path):
			var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, "D0293746ZgA")
			var data = file.get_var()
			file.close()
			
			var save_name = data.get("save_name", "Unknown Save")
			button.text = "Save %d - %s" % [i, save_name]
		else:
			button.text = "Save %d - Empty" % i

func slot_pressed(save:int):
	
	SaveManager.current_save = save
	
	var path = SaveManager.get_save_path(save)
	
	if FileAccess.file_exists(path):
		print("Loading save")
	else:
		print("Creating new save")
		
	get_tree().change_scene_to_file("res://Scenes/Areas/debug_world.tscn")
