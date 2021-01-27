extends Node2D

onready var base_enemy: BaseEnemy = $BaseEnemy
onready var texture = load("res://enemies/Bat/bat.png")
onready var hurt_texture = load("res://enemies/Bat/bat_hurt.png")
export var health: int = 1

func _ready():
	base_enemy.set_can_see(false)
	base_enemy.set_texture(texture)
	base_enemy.set_hurt_texture(hurt_texture)
	base_enemy.set_max_health(health)
