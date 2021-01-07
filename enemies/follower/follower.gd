class_name Follower extends KinematicBody2D

onready var player: Player = get_tree().get_root().find_node("player", true, false) as Player
var speed: float = 50
var follow_player: bool = false
var first_time: bool = true

func _physics_process(delta):
	if follow_player:
		look_at(player.global_position)
		move_and_slide(Vector2(speed, 0).rotated(rotation))

func _on_Area2D_body_entered(body):
	if not body.get('type'):
		return
		
	follow_player = true


func _on_Area2D_body_exited(body):
	if not body.get('type'):
		return
		
	follow_player = false
