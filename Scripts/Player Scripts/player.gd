extends CharacterBody2D

class_name Player

#Exported variables

@export var MAX_HEALTH : int = 100
@export var MAX_MANA : int = 100
@export var MAX_JUMPS := 2
@export var MAX_DASHES : int = 1
@export var WALK_SPEED = 200
@export var JUMP_SPEED = -400
@export var DASH_SPEED := 600
@export var DASH_TIME := 0.15
@export var ALLOW_MIDAIR_STEERING := true
@onready var attack_hitbox: Area2D = $"Attack Hitbox"

#Player UI

var HEALTH_REMAINING : int 
var MANA_REMAINING : int
var JUMPS_REMAINING : int
var DASHES_REMAINING : int

#Variables

var IS_INVINCIBLE := false	
const GRAVITY = 980

func _ready():
	
	if GameManager.player and GameManager.player != self:
		queue_free()
		return
	
	GameManager.player = self
	
	add_to_group("player")
	HEALTH_REMAINING = MAX_HEALTH
	MANA_REMAINING = MAX_MANA
	JUMPS_REMAINING = MAX_JUMPS
	DASHES_REMAINING = MAX_DASHES
	
	print("Loading game...")
	SaveManager._load(self)
	
	await get_tree().process_frame
	DoorManager.spawn_player()

func start_iframes(duration: float):
	IS_INVINCIBLE = true
	await get_tree().create_timer(duration).timeout
	IS_INVINCIBLE = false

func _input(event):
	if event.is_action_pressed("Save"):
		print("Saving game...")
		SaveManager._save(self)
