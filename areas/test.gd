extends Node2D


func _ready():
	$player.global_position.x = GameState.start_position_x
	$player.global_position.y = GameState.start_position_y
