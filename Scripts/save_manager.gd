extends Node

const save_location := "user://saveFile.json"

var contents_to_save: Dictionary = {
	"money":0,
	"health":0,
	"mana": 0,
	"coins": {}
}

func _save(player: Player):
	
	contents_to_save["money"] = Global.MONEY
	contents_to_save["health"] = player.HEALTH_REMAINING
	contents_to_save["mana"] = player.MANA_REMAINING
	contents_to_save["coins"] = Global.COLLECTED_COINS
	var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.WRITE, "D0293746ZgA")
	file.store_var(contents_to_save.duplicate())
	file.close()
	
func _load(player: Player):
	
	if not FileAccess.file_exists(save_location):
		return
		
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.READ, "D0293746ZgA")
		var data = file.get_var()
		file.close()
		
		if data is Dictionary:
			contents_to_save = data
		
		Global.MONEY = contents_to_save["money"]
		player.HEALTH_REMAINING = contents_to_save["health"]
		player.MANA_REMAINING = contents_to_save["mana"]
		Global.COLLECTED_COINS = contents_to_save["coins"]
