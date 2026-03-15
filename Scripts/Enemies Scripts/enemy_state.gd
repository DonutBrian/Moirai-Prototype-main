extends State
class_name EnemyState

var enemy: Enemy
var sprite: AnimatedSprite2D

func enter():
	enemy = character as Enemy
	sprite = enemy.get_node("AnimatedSprite2D")
