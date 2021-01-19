extends Node2D

var fire_texture = load("res://tiles/grass/fire.png")
var on_fire: bool = false
var damage = 1
	

func _on_Timer_timeout():
	$Sprite.visible = false
	$Timer.stop()
	
	for child in $Area2D2.get_overlapping_areas():
		var parent = child.get_parent()
		if parent.has_method("catch_fire"):
			parent.catch_fire()
	
	on_fire = false
	queue_free()
		
	
func catch_fire():
	on_fire = true
	$Sprite.texture = fire_texture
	$Timer.start()


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("get_fire_state"):
		if parent.get_fire_state():
			catch_fire()
