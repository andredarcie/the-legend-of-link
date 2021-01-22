extends Area2D

func _on_Teleporter_body_entered(body):
	print(body.name)
	if body.get("type") != null:
		if body.type == "player":
			get_tree().change_scene("res://areas/Dungeon.tscn")
