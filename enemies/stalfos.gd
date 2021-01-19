class_name Stalfos extends Entity

var move_timer_length: float = 15
var movetimer: int = 0
var damage: float = 0.25
var is_following := false
var stopped: bool = false
onready var player: Player = get_tree().get_root().get_node("Node2D/player")
var move

var alert_texture = load("res://enemies/Enemy/alert.png")
var suspicious_texture = load("res://enemies/Enemy/suspicious.png")

func _ready() -> void:
	speed = 40
	$anim.play('default')
	movedir = dir.rand()
	$Balloon.visible = false
	

func _physics_process(delta: float) -> void:
	move = Vector2.ZERO
	
	if stopped:
		return
	
	if is_following and is_on_wall():
		is_following = false
		speed = 40
		suspicious()
		
	if is_following:
		speed = 50
		move = position.direction_to(player.position) * speed
		move_and_slide(move, Vector2(0, 0))
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


func suspicious():
	$Balloon.visible = true
	$Balloon.texture = suspicious_texture
	$SuspiciousTimer.start()


func _on_SuspiciousTimer_timeout():
	$Balloon.visible = false
