extends Node2D

onready var base_enemy: BaseEnemy = $BaseEnemy
onready var zombie_texture = load("res://enemies/Zombie/zombie.png")

func _ready():
	base_enemy.set_can_see(true)
	base_enemy.set_texture(zombie_texture)
