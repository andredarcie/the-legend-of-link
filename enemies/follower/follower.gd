class_name Follower extends KinematicBody2D

var speed := 40.0
var path := PoolVector2Array() setget set_path

func _ready():
	set_process(false)
	
	
func _process(delta: float) -> void:
	var move_distance := speed * delta
	move_along_path(move_distance)
	
	
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

