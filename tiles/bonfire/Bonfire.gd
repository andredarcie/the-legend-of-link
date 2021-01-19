extends Area2D

var damage = 1

func _on_Bonfire_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("catch_fire"):
		parent.catch_fire()
