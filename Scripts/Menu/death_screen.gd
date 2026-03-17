extends Control
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_reload_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Areas/debug_world.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
	
func _on_quit_pressed() -> void:
	
	if player:
		SaveManager._save(player,SaveManager.current_save)
		
	get_tree().quit()
