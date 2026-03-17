extends Control

var selected_class = null
var unlocked_skills = {}

@onready var class_menu: VBoxContainer = $"Class Select Menu"
@onready var tree: Control = $Tree

func _on_knight_pressed() -> void:
	select_class("knight")

func _on_archer_pressed() -> void:
	select_class("archer")

func _on_assassin_pressed() -> void:
	select_class("assassin")

func _on_warlock_pressed() -> void:
	select_class("warlock")

func _on_druid_pressed() -> void:
	select_class("druid")

func select_class(name):
	selected_class = name
	class_menu.visible = false
	tree.visible = true
	load_tree(name)


var skill_trees = {
	"knight": [
		{"name": "Slash", "pos": Vector2(200,100)},
		{"name": "Shield Block", "pos": Vector2(200,200)}
	],
	
	"archer": [
		{"name": "Quick Shot", "pos": Vector2(200,100)},
		{"name": "Piercing Arrow", "pos": Vector2(200,200)}
	],
	
	"assassin": [
		{"name": "Backstab", "pos": Vector2(200,100)},
		{"name": "Dash Strike", "pos": Vector2(200,200)}
	],
	
	"warlock": [
		{"name": "Shadow Bolt", "pos": Vector2(200,100)},
		{"name": "Life Drain", "pos": Vector2(200,200)}
	],
	
	"druid": [
		{"name": "Nature Touch", "pos": Vector2(200,100)},
		{"name": "Root Bind", "pos": Vector2(200,200)}
	]
}

func load_tree(name):
	for child in tree.get_children():
		child.queue_free()
	var selected_tree = skill_trees.get(name, [])
	for skill in selected_tree:
		create_skill(skill["name"], skill ["pos"])
		
func create_skill(name, pos):
	var button = Button.new()
	button.text = name
	button.position = pos
	button.pressed.connect(func(): unlock_skill(name, button))
	tree.add_child(button)

func unlock_skill(skill_name, button):
	if unlocked_skills.has(skill_name):
		return
	unlocked_skills[skill_name] = true
	button.disabled = true
	button.text += "(Unlocked)"
