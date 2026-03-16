extends Node

var current_save : int = 0

var contents_to_save: Dictionary = {
	"save_name": "",
	"money":0,
	"health":0,
	"mana": 0,
	"coins": {}
}

func get_save_path(save:int) -> String:
	return "user://saveFile_%d.json" % save


func _save(player: Player, save:int):
	
	var save_location = get_save_path(save)
	contents_to_save["save_name"] = generate_save_name()
	contents_to_save["money"] = Global.MONEY
	contents_to_save["health"] = player.HEALTH_REMAINING
	contents_to_save["mana"] = player.MANA_REMAINING
	contents_to_save["coins"] = Global.COLLECTED_COINS
	
	var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.WRITE, "D0293746ZgA")
	file.store_var(contents_to_save.duplicate())
	file.close()
	
func _load(player: Player, save:int):
	
	var save_location = get_save_path(save)
	
	if not FileAccess.file_exists(save_location):
		return
		
	var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.READ, "D0293746ZgA")
	var data = file.get_var()
	file.close()
		
	if data is Dictionary:
		contents_to_save = data
		
	Global.MONEY = contents_to_save["money"]
	player.HEALTH_REMAINING = contents_to_save["health"]
	player.MANA_REMAINING = contents_to_save["mana"]
	Global.COLLECTED_COINS = contents_to_save["coins"]

func generate_save_name() -> String:
	var names = ["Apollo", "Ares", "Artemis", "Athena", "Demeter", "Dionysus", "Hera", "Hermes", "Poseidon", "Zeus"]
	return names.pick_random()
