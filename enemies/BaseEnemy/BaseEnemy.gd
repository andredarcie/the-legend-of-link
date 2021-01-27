class_name BaseEnemy extends Entity

var move_timer_length: float = 15
var movetimer: int = 0
var damage: float = 0.25
var is_following := false
var can_follow: bool = false
var stopped: bool = false
var can_shoot_magic_balls: bool = false
var magic_texture = null
onready var player: Player = get_tree().root.get_child(2).get_node("player")
var move
var texture_default_cache = null
var alert_texture = load("res://enemies/BaseEnemy/alert.png")
var suspicious_texture = load("res://enemies/BaseEnemy/suspicious.png")

func _ready() -> void:
	speed = 40
	$anim.play('default')
	movedir = dir.rand()
	$Balloon.visible = false
	$Sprite.texture = load("res://enemies/Zombie/zombie.png")
	
	
func set_can_see(can_see: bool):
	if can_see:
		$Vision/CollisionShape2D.disabled = false
	else:
		$Vision/CollisionShape2D.disabled = true

func set_texture(texture: Texture):
	texture_default = texture
	
func set_hurt_texture(texture: Texture):
	texture_hurt = texture
	
func set_max_health(health):
	max_health = health

func _physics_process(_delta: float) -> void:
	move = Vector2.ZERO
	knockdir = Vector2.ZERO
	
	damage_loop()
	
	if is_following and is_on_wall() and global_position.distance_to(player.global_position) > 60:
		suspicious_mode()
		
	if is_following:
		speed = 40
		
		if not knockdir.normalized() == Vector2(0, 0):
			move = knockdir.normalized() * 1500
		else:
			move = global_position.direction_to(player.global_position) * speed
			
		move_and_slide(move, Vector2(0, 0))
		return
	else:
		if hitstun == 0:
			move = movedir.normalized() * speed
		else:
			move = knockdir.normalized() * 125
		
		move_and_slide(move, Vector2(0, 0))
		
		if movetimer > 0:
			movetimer -= 1
		if movetimer == 0 || is_on_wall():
			movedir = dir.rand()
			movetimer = move_timer_length
		

func _on_Vision_body_entered(body):
	if body.get("type") == "player":
		alert_mode()
		

func alert_mode():
	$Balloon.visible = true
	$Balloon.texture = alert_texture
	
	if can_follow:
		is_following = true
	
	if can_shoot_magic_balls:
		$MagicBallTimer.start()
		
	
func suspicious_mode():
	is_following = false
	speed = 40
	$Balloon.visible = true
	$Balloon.texture = suspicious_texture
	$SuspiciousTimer.start()
	$MagicBallTimer.stop()


func _on_SuspiciousTimer_timeout():
	if !is_following:
		$Balloon.visible = false


func _on_MagicBallTimer_timeout():
	$GatherMagicTimer.start()
	
	texture_default_cache = texture_default
	texture_default = magic_texture
	
	
func shoot_magic_ball():
	var new_scene = load("res://enemies/BaseEnemy/MagicBall.tscn").instance()
	add_child_below_node(get_tree().get_root().get_node("Node2D"), new_scene)


func _on_GatherMagicTimer_timeout():
	$GatherMagicTimer.stop()
	
	texture_default = texture_default_cache
		
	shoot_magic_ball()


func _on_Range_body_exited(body):
	if not body.get("type") == null:
		if body.type == "player":
			suspicious_mode()
