extends OptionButton

@onready var res_options: OptionButton = $"."

func _ready():
	res_options.add_item("1280x720")
	res_options.add_item("1920x1080")
	res_options.add_item("2560x1440")

func _on_item_selected(index: int) -> void:
	
	var resolutions = [
		Vector2i(1280,720),
		Vector2i(1920,1080),
		Vector2i(2560,1440)
	]
	
	DisplayServer.window_set_size(resolutions[index])
