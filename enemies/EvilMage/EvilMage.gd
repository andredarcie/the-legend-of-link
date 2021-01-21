extends Node2D

onready var base_enemy = get_node("BaseEnemy")
onready var texture = load("res://enemies/EvilMage/evil_mage.png")
onready var magic_texture = load("res://enemies/EvilMage/evil_mage_magic.png")

func _ready():
	base_enemy.set_can_see(true)
	base_enemy.set_texture(texture)
	base_enemy.can_shoot_magic_balls = true
	base_enemy.can_follow = false
	base_enemy.magic_texture = magic_texture
