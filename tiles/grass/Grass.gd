extends Node2D

var fire_texture = load("res://tiles/grass/fire.png")
var grass_texture = load("res://tiles/grass/grass.png") 
onready var left_collision = $Left
onready var right_collision = $Right
onready var up_collision = $Up
onready var down_collision = $Down


func _ready():
	$Sprite.texture = grass_texture

func _on_Area2D_body_entered(body):
	if body.get("type") == "player":
		catch_fire()


func _on_Timer_timeout():
	$Sprite.visible = false
	$Timer.stop()
	if left_collision.is_colliding():
		call_fire(left_collision)
	if right_collision.is_colliding():
		call_fire(right_collision)
	if up_collision.is_colliding():
		call_fire(up_collision)
	if down_collision.is_colliding():
		call_fire(down_collision)
	
	queue_free()
		
func call_fire(ray_cast: RayCast2D):
	var area2D = ray_cast.get_collider()
	var parent = area2D.get_parent()
	if parent.has_method("catch_fire"):
		parent.catch_fire()
	
func catch_fire():
	$Sprite.texture = fire_texture
	$Timer.start()
