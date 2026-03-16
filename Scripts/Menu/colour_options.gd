extends OptionButton

@onready var colour_options: OptionButton = $"."

func _ready():
	colour_options.add_item("Normal")
	colour_options.add_item("Protanopia")
	colour_options.add_item("Deuteranopia")
	colour_options.add_item("High Contrast")
	
func _on_item_selected(index: int) -> void:
	match index:
		0:
			print("Normal colours")
		
		1:
			print("Protanopia mode")
			
		2:
			print("Deuteranopia mode")
			
		3:
			print("High Contrast mode")
