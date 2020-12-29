class_name Switch extends Area2D

var proximity: bool = false
var active: bool = false
var await_time: float = 0

var on_image: Texture = preload("res://pickups/switch/green.png")
var off_image: Texture = preload("res://pickups/switch/off.png")

func _on_switch_body_entered(_body: Node2D) -> void:
	self.proximity = true

func _on_switch_body_exited(_body: Node2D) -> void:
	self.proximity = false
	
func _physics_process(_delta: float) -> void:	
	if self.active:
		$Sprite.texture = on_image
	else:
		$Sprite.texture = off_image
		
	if self.await_time > 0:
		self.await_time = self.await_time - 1
	
	var key_press: bool = Input.is_action_pressed("ui_accept")
	if await_time == 0 && key_press && self.proximity:
		self.active = !self.active
		self.await_time = 10
