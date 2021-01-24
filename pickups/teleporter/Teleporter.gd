extends Area2D

export var start_position_x: int = 0
export var start_position_y: int = 0

func _on_Teleporter_body_entered(body):
	if body.get("type") != null:
		if body.type == "player":
			GameState.go_to_scene(start_position_x, start_position_y, name)
