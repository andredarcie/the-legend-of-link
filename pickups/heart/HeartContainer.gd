extends Area2D


func _ready():
	pass


func _on_HeartContainer_body_entered(body):
	if body.has_method("gain_max_health"):
		body.gain_max_health(1)
		queue_free()

