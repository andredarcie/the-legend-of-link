extends Node2D

enum DIRECTION {
	right,
	left,
	up,
	down
}

var speed = 140
export var max_distance = 100
export(DIRECTION) var direction = DIRECTION.down

func _ready():
	pass

func _physics_process(delta):
	var direction_to_go = Vector2.ZERO
	
	if direction == DIRECTION.down:
		direction_to_go = Vector2(0, 1)
	elif direction == DIRECTION.up:
		direction_to_go = Vector2(0, -1)
	elif direction == DIRECTION.right:
		direction_to_go = Vector2(1, 0)
	elif direction == DIRECTION.left:
		direction_to_go = Vector2(-1, 0)
		
	$Bullet.global_position += direction_to_go * delta * speed
	
	if $Bullet.global_position.distance_to(global_position) > max_distance:
		$Bullet.global_position = global_position


func _on_Bullet_body_entered(body):
	if body.get("type") != null:
		if body.has_method("make_damage"):
			body.make_damage($Bullet)
			$Bullet.global_position = global_position
