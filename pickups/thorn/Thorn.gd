extends Area2D

var activeThron: bool = false
var icon: Texture = preload('res://icon.png')

func _process(_delta: float) -> void:
	if self.activeThron:
		$Sprite.texture = null
		$CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	else:
		$Sprite.texture = icon
		$CollisionShape2D.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		
	
