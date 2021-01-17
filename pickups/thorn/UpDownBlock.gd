extends Area2D

var active: bool = false
var up_image: Texture = preload("res://pickups/thorn/up.png")
var down_image: Texture = preload("res://pickups/thorn/down.png")

func _process(_delta: float) -> void:
	if self.active:
		$Sprite.texture = down_image
		$CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	else:
		$Sprite.texture = up_image
		$CollisionShape2D.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		
	
