class_name Stalfos extends Entity

var move_timer_length: float = 15
var movetimer: int = 0
var damage: float = 0.25

func _ready() -> void:
	speed = 40
	$anim.play('default')
	movedir = dir.rand()

func _physics_process(delta: float) -> void:
	movement_loop()
	damage_loop()
	
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movedir = dir.rand()
		movetimer = move_timer_length
