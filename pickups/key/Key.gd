class_name Key extends Pickup
	
func body_entered(body: Node2D) -> void:
	if body.name == 'player' && body.get('keys') < 9:
		body.keys += 1
		queue_free()
