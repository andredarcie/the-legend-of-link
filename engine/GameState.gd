extends Node

var island = preload("res://areas/test.tscn")
var dungeon = preload("res://areas/Dungeon.tscn")
var old_forest = preload("res://areas/OldForest.tscn")

var start_position_x: int = 0
var start_position_y: int = 0
var coins: int = 0
var keys: int = 0

func go_to_scene(x: int, y: int):
	start_position_x = x
	start_position_y = y
	
	var current_scene_name = get_tree().current_scene.name
	if current_scene_name == "Dungeon":
		get_tree().change_scene_to(island)
		
	elif current_scene_name == "Node2D":
		get_tree().change_scene_to(dungeon)
		
		
func set_player_start_position(player):
	player.global_position.x = start_position_x
	player.global_position.y = start_position_y
