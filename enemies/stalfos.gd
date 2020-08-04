extends "res://engine/entity.gd"

var move_timer_length = 15
var movetimer = 0
var damage = 1

func _ready():
	speed = 40
	$anim.play('default')
	movedir = dir.rand()

func _physics_process(delta):
	movement_loop()
	damage_loop()
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = move_timer_length
