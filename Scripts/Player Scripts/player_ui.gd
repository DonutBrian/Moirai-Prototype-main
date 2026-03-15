extends Control

@export var player_path: NodePath

@onready var health_bar: TextureProgressBar = $"Right Hand Side/Health Bar"
@onready var mana_bar: TextureProgressBar = $"Right Hand Side/Mana Bar"
@onready var jump_bar: TextureProgressBar = $"Right Hand Side/Jump Bar"
@onready var dash_bar: TextureProgressBar = $"Right Hand Side/Dash Bar"
@onready var money_counter: Label = $"Left Hand Side/Money Counter"

var player: Player

func _ready():
	player = get_node_or_null(player_path) as Player

func _process(_delta):
	if not player:
		return
	
	health_bar.max_value = player.MAX_HEALTH
	health_bar.value = player.HEALTH_REMAINING
	
	mana_bar.max_value = player.MAX_MANA
	mana_bar.value = player.MANA_REMAINING
	
	jump_bar.max_value = player.MAX_JUMPS
	jump_bar.value = player.JUMPS_REMAINING
	
	dash_bar.max_value = player.MAX_DASHES
	dash_bar.value = player.DASHES_REMAINING
	
	money_counter.text = "Money: %d" % Global.MONEY
	
