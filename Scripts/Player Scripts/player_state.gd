extends State
class_name PlayerState

var player: Player
var sprite: AnimatedSprite2D

func enter():
	player = character as Player
	sprite = player.get_node("AnimatedSprite2D")
