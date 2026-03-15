extends CharacterBody2D
class_name Enemy

@onready var Hitbox: DamageZone = $Hitbox
@onready var state_machine: EnemyStateMachine = $StateMachine

@export var MAXIMUM_HEALTH := 50
@export var MOVE_SPEED := 80
@export var DETECTION_RANGE := 120
@export var ATTACK_RANGE := 32

var HEALTH_REMAINING := 0
var IS_INVINCIBLE := false
var SPAWN = false
const GRAVITY = 980

func _ready():
	HEALTH_REMAINING = MAXIMUM_HEALTH
	
	if $"Enemy UI":
		$"Enemy UI".target_enemy = self
	
func start_iframes(duration: float):
	IS_INVINCIBLE = true
	await get_tree().create_timer(duration).timeout
	IS_INVINCIBLE = false
	
func take_damage(damage: int, knockback_force: float, hit_pos: Vector2):
	print("Ouchie")
	
	if IS_INVINCIBLE:
		return
	
	state_machine.PENDING_DAMAGE = damage
	state_machine.PENDING_KNOCKBACK_FORCE = knockback_force
	state_machine.PENDING_HIT_POSITION = hit_pos
	
	state_machine.change_state("enemyhurtstate")
	
	if $"Enemy UI":
		$"Enemy UI".visible = true
		$"Enemy UI".visible_timer = $"Enemy UI".fade_time
