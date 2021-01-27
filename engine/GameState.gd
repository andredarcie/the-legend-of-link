extends Node

var island = preload("res://areas/test.tscn")
var dungeon = preload("res://areas/Dungeon.tscn")

# New places
var CentralAreaPlain = preload("res://areas/Plains/CentralAreaPlain.tscn")

var CentralAreaDesert = preload("res://areas/Deserts/CentralAreaDesert.tscn")
var CentralAreaGiantForest = preload("res://areas/GiantForests/CentralAreaGigantForest.tscn")
var CentralAreaIcyMountain = preload("res://areas/IcyMountains/CentralAreaIcyMountain.tscn")
var CentralAreaJungle = preload("res://areas/Jungles/CentralAreaJungle.tscn")
var CentralAreaSoullessCastle = preload("res://areas/SoullessCastle/CentralAreaSoullessCastle.tscn")
var CentralAreaSwamp = preload("res://areas/Swamps/CentralAreaSwamp.tscn")
var CentralAreaVillage = preload("res://areas/Villages/CentralAreaVillage.tscn")
var CentralAreaVolcano = preload("res://areas/Volcano/CentralAreaVolcano.tscn")
var CentralAreaDungeon = preload("res://areas/Dungeons/CentralAreaDungeon.tscn")

var start_position_x: int = 0
var start_position_y: int = 0
var coins: int = 10
var keys: int = 0
var player_health: int = 3
var player_max_health: int = 3
var player_arrows: int = 10

func go_to_scene(x: int, y: int, name: String):
	start_position_x = x
	start_position_y = y
	
	if name == "EnterCentralAreaDesert":
		get_tree().change_scene_to(CentralAreaDesert)
	elif name == "EnterCentralAreaGiantForest":
		get_tree().change_scene_to(CentralAreaGiantForest)
	elif name == "EnterCentralAreaIcyMountain":
		get_tree().change_scene_to(CentralAreaIcyMountain)
	elif name == "EnterCentralAreaJungle":
		get_tree().change_scene_to(CentralAreaJungle)
	elif name == "EnterCentralAreaSoullessCastle":
		get_tree().change_scene_to(CentralAreaSoullessCastle)
	elif name == "EnterCentralAreaSwamp":
		get_tree().change_scene_to(CentralAreaSwamp)
	elif name == "EnterCentralAreaVillage":
		get_tree().change_scene_to(CentralAreaVillage)
		start_position_x = 160
		start_position_y = 24
	elif name == "EnterCentralAreaVolcano":
		get_tree().change_scene_to(CentralAreaVolcano)
	elif name == "EnterCentralAreaDungeon":
		get_tree().change_scene_to(CentralAreaDungeon)
		
	if name == "ExitCentralAreaDesert":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = -232
		start_position_y = 208
		
	elif name == "ExitCentralAreaGiantForest":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = 648
		start_position_y = 304
		
	elif name == "ExitCentralAreaIcyMountain":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = 632
		start_position_y = 112
		
	elif name == "ExitCentralAreaJungle":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = -248
		start_position_y = 392
		
	elif name == "ExitCentralAreaSoullessCastle":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = 184
		start_position_y = -160
		
	elif name == "ExitCentralAreaSwamp":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = -184
		start_position_y = 32
		
	elif name == "ExitCentralAreaVillage":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = 136
		start_position_y = 560
		
	elif name == "ExitCentralAreaVolcano":
		get_tree().change_scene_to(CentralAreaPlain)
		start_position_x = 472
		start_position_y = 512
		
	elif name == "ExitDungeonToCentralVillage":
		get_tree().change_scene_to(CentralAreaVillage)
		start_position_x = 328
		start_position_y = 280
		
		
func set_player_start_position(player):
	player.global_position.x = start_position_x
	player.global_position.y = start_position_y


func get_current_scene_name() -> String:
	return get_tree().current_scene.name
	
func restart_game():
	get_tree().reload_current_scene()
	player_health = 3
	player_max_health = 3
	player_arrows = 10
