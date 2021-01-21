extends KinematicBody2D

onready var player: Player = get_tree().get_root().get_node("Node2D/player")

var last_player_position
var move
var damage = 1

func _ready():
	last_player_position = player.global_position


func _physics_process(delta):
	if global_position.floor() == last_player_position.floor():
		queue_free()
	else:
		move = global_position.direction_to(last_player_position) * 200
		move_and_slide(move, Vector2(0, 0))
