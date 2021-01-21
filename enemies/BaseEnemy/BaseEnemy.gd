class_name BaseEnemy extends Entity

var move_timer_length: float = 15
var movetimer: int = 0
var damage: float = 0.25
var is_following := false
var stopped: bool = false
var shoot_magic_balls: bool = false
onready var player: Player = get_tree().get_root().get_node("Node2D/player")
var move

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
		$Vision/CollisionPolygon2D.disabled = false
	else:
		$Vision/CollisionPolygon2D.disabled = true

func set_texture(texture: Texture):
	texture_default = texture
	
func set_hurt_texture(texture: Texture):
	texture_hurt = texture
	
func set_max_health(health):
	max_health = health

func _physics_process(_delta: float) -> void:
	move = Vector2.ZERO
	
	if stopped:
		return

	
	if is_following and is_on_wall() and global_position.distance_to(player.global_position) > 60:
		suspicious()
		
	if is_following:
		speed = 50
		move = global_position.direction_to(player.global_position) * speed
		move_and_slide(move, Vector2(0, 0))
		damage_loop()
	else:
		movement_loop()
		damage_loop()
		
		if movetimer > 0:
			movetimer -= 1
		if movetimer == 0 || is_on_wall():
			movedir = dir.rand()
			movetimer = move_timer_length


func _on_Vision_body_entered(body):
	if body.get("type") == "player":
		$Balloon.visible = true
		$Balloon.texture = alert_texture
		is_following = true
		if shoot_magic_balls:
			$MagicBallTimer.start()


func suspicious():
	is_following = false
	speed = 40
	$Balloon.visible = true
	$Balloon.texture = suspicious_texture
	$SuspiciousTimer.start()


func _on_SuspiciousTimer_timeout():
	if !is_following:
		$Balloon.visible = false


func _on_MagicBallTimer_timeout():
	var new_scene = load("res://enemies/BaseEnemy/MagicBall.tscn").instance()
	add_child_below_node(get_tree().get_root().get_node("Node2D"), new_scene)
