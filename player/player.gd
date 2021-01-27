class_name Player extends Entity

var state: String = 'default'
var sword_on_fire: bool = false
var sword = preload('res://items/sword.tscn')
var arrow_direction = DIRECTION.Up
onready var arrow = preload("res://player/Arrow.tscn")

signal player_move

enum DIRECTION {
	Up,
	Down,
	Left,
	Right
}

func _init() -> void:
	type = 'player'
	max_health = GameState.player_max_health
	health = GameState.player_health
	
func _ready() -> void:
	speed = 90
	$Bow.visible = false
	

func _physics_process(delta: float) -> void:
	match state:
		'default':
			state_default()
		'swing':
			state_swing()
	
	GameState.keys = min(GameState.keys, 9)
	
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
		use_item(sword)
		
	if Input.is_action_just_pressed("b"):
		shoot_arrow()

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
	
func add_coin():
	GameState.coins += 1
	
func arrow_direction():
	match spritedir:
		'left':
			set_bow_position_and_rotation(-11.024, 0, 136)
			arrow_direction = DIRECTION.Left
		'right':
			set_bow_position_and_rotation(8.504, 0.315, -45)
			arrow_direction = DIRECTION.Right
		'up':
			set_bow_position_and_rotation(0.112, -11.136, 225.1)
			arrow_direction = DIRECTION.Up
		'down':
			set_bow_position_and_rotation(0.112, 11.582, 45)
			arrow_direction = DIRECTION.Down


func set_bow_position_and_rotation(x, y, rotation_degress):
	$Bow.position.x = x
	$Bow.position.y = y
	$Bow.rotation_degrees = rotation_degress
	

func shoot_arrow():
	if GameState.player_arrows > 0:
		GameState.player_arrows -= 1
		arrow_direction()
		$Bow.visible = true
		var new_arrow = arrow.instance()
		new_arrow.set_direction_and_point_of_origin(arrow_direction, global_position)
		get_node('..').add_child(new_arrow)
		$Bow/BowTimer.start()


func _on_BowTimer_timeout():
	$Bow.visible = false
	$Bow/BowTimer.stop()
