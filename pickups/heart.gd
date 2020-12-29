class_name Heart extends Pickup

func body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.health += 1
		queue_free()
