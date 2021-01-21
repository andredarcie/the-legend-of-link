extends Node2D

onready var base_enemy: BaseEnemy = $BaseEnemy
onready var texture = load("res://enemies/EvilMage/evil_mage.png")

func _ready():
	base_enemy.set_can_see(true)
	base_enemy.set_texture(texture)
	base_enemy.shoot_magic_balls = true
