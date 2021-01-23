extends Area2D

var active: bool = false
var damage = 1

func _process(_delta: float) -> void:
	if self.active:
		$Sprite.frame = 1
		$CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	else:
		$Sprite.frame = 0
		$CollisionShape2D.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		$DamageArea/CollisionShape2D.set_deferred("disabled", false)
