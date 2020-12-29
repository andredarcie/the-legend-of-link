extends Node2D

var type: String = ''
var damage: int = 1
var maxamount: int = 1

func _ready() -> void:
	type = get_parent().type
	$anim.connect("animation_finished", self, 'destroy')
	$anim.play(str('swing', get_parent().spritedir))
	if get_parent().has_method('state_swing'):
		get_parent().state = 'swing'

func destroy(_animation) -> void:
	if get_parent().has_method('state_swing'):
		get_parent().state = 'default'
	queue_free()
