class_name Player extends Entity

var state: String = 'default'
var keys: int = 0
var sword_on_fire: bool = false

signal player_move

func _init() -> void:
	type = 'player'
	max_health = 10
	health = 10
	
func _ready() -> void:
	speed = 70

func _physics_process(delta: float) -> void:
	match state:
		'default':
			state_default()
		'swing':
			state_swing()
	
	keys = min(keys, 9)
	
func state_default() -> void:
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
		emit_signal("player_move")
		anim_switch('walk')
	else:
		anim_switch('idle')
	
	if Input.is_action_just_pressed("a"):
		use_item(preload('res://items/sword.tscn'))

func state_swing() -> void:
	anim_switch('idle')
	movement_loop()
	damage_loop()
	movedir = dir.center
	
func controls_loop() -> void:
	var LEFT: bool  = Input.is_action_pressed("ui_left")
	var RIGHT: bool = Input.is_action_pressed("ui_right")
	var UP: bool    = Input.is_action_pressed("ui_up")
	var DOWN: bool  = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)

func sword_catch_fire():
	sword_on_fire = true
	$SwordOnFireTimer.start()

func _on_SwordOnFireTimer_timeout():
	sword_on_fire = false
	$SwordOnFireTimer.stop()
