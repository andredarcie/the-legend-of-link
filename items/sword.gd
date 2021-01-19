extends Node2D

var type: String = ''
var damage: int = 1
var maxamount: int = 1
onready var fire_sword_texture = load("res://items/fire_sword.png")
onready var sword_texture = load("res://items/sword.png")
	
func _ready() -> void:
	type = get_parent().type
	$anim.connect("animation_finished", self, 'destroy')
	$anim.play(str('swing', get_parent().spritedir))
	if get_parent().has_method('state_swing'):
		get_parent().state = 'swing'
	
	
	var parent = get_parent()
	if parent.get('sword_on_fire'):
		if parent.sword_on_fire:
			$Sprite.texture = fire_sword_texture
		else:
			$Sprite.texture = sword_texture
		

func destroy(_animation) -> void:
	if get_parent().has_method('state_swing'):
		get_parent().state = 'default'
	queue_free()
	

func get_fire_state():
	return get_parent().sword_on_fire
	
func catch_fire():
	get_parent().sword_catch_fire()
