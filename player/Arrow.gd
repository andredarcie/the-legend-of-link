extends Sprite

enum DIRECTION {
	Up,
	Down,
	Left,
	Right
}

var direction = DIRECTION.Down
var point_of_origin = Vector2.ZERO
var speed = 150
var move = Vector2.ZERO

func _ready():
	set_start_position()

func _physics_process(delta):
	move = Vector2.ZERO
	
	match direction:
		DIRECTION.Left:
			move = Vector2(-1, 0) * delta * speed
		DIRECTION.Right:
			move = Vector2(1, 0) * delta * speed
		DIRECTION.Up:
			move = Vector2(0, -1) * delta * speed
		DIRECTION.Down:
			move = Vector2(0, 1) * delta * speed
			
	global_position += move
	
func set_direction_and_point_of_origin(direction, point_of_origin):
	self.direction = direction
	self.point_of_origin = point_of_origin


func set_start_position():
	match direction:
		DIRECTION.Left:
			set_arrow_position_and_rotation(point_of_origin.x - 21.648, point_of_origin.y - 0.138, 225)
		DIRECTION.Right:
			set_arrow_position_and_rotation(point_of_origin.x + 21.227, point_of_origin.y - 0.138, 44.4)
		DIRECTION.Up:
			set_arrow_position_and_rotation(point_of_origin.x - 0.043, point_of_origin.y - 22.633, 314.1)
		DIRECTION.Down:
			set_arrow_position_and_rotation(point_of_origin.x - 0.155, point_of_origin.y + 23.694, 137.1)


func set_arrow_position_and_rotation(x, y, degrees):
	global_position.x = x
	global_position.y = y
	rotation_degrees = degrees
	
	
func _on_ArrowLifeTimer_timeout():
	print("morreu")
	queue_free()
