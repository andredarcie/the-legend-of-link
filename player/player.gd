extends Entity

var state = 'default'

func _ready():
	speed = 70
	type = 'player'

func _physics_process(delta):
	match state:
		'default':
			state_default()
		'swing':
			state_swing()

func state_default():
	controls_loop()
	movement_loop()
	spriterdir_loop()
	damage_loop()
	
	if is_on_wall() and movedir != Vector2(0, 0):
		if spritedir == 'left' and test_move(transform, Vector2(-1, 0)):
			anim_switch('push')
		if spritedir == 'right' and test_move(transform, Vector2(1, 0)):
			anim_switch('push')
		if spritedir == 'up' and test_move(transform, Vector2(0, -1)):
			anim_switch('push')
		if spritedir == 'down' and test_move(transform, Vector2(0, 1)):
			anim_switch('push')
	elif movedir != Vector2(0, 0):
		anim_switch('walk')
	else:
		anim_switch('idle')
	
	if Input.is_action_just_pressed("a"):
		use_item(preload('res://items/sword.tscn'))

func state_swing():
	anim_switch('idle')
	movement_loop()
	damage_loop()
	movedir = dir.center
	
func controls_loop():
	var LEFT  = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP    = Input.is_action_pressed("ui_up")
	var DOWN  = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
