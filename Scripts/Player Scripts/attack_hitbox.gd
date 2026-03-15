extends Area2D

@export var damage := 1
@export var knockback_force := 300

func _on_area_entered(area: Area2D) -> void:
	
	var enemy = area.get_parent()
	
	if enemy.has_method("take_damage"):
		print("theres something here")
		enemy.take_damage(damage, knockback_force, global_position)
