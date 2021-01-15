class_name Stalfos extends Entity

var move_timer_length: float = 15
var movetimer: int = 0
var damage: float = 0.25
var path := PoolVector2Array() setget set_path
var is_following := false

func _ready() -> void:
	speed = 40
	$anim.play('default')
	movedir = dir.rand()

func _physics_process(delta: float) -> void:
	if is_following:
		var move_distance := speed * delta
		move_along_path(move_distance)
	else:
		movement_loop()
		damage_loop()
		
		if movetimer > 0:
			movetimer -= 1
		if movetimer == 0 || is_on_wall():
			movedir = dir.rand()
			movetimer = move_timer_length

func move_along_path(distance : float) -> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif path.size() == 1 && distance > distance_to_next:
			position = path[0]
			set_process(false)
			break
			
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
