extends Camera2D

onready var player := get_parent() as Player

func _ready():
	global_position = Vector2(player.global_position.x - (320 / 2),
							  player.global_position.y - (180 / 2))
	$area.connect('body_entered', self, 'body_entered')
	$area.connect('body_exited', self, 'body_exited')
	$area.connect('area_exited', self, 'area_exited')
	
func _process(delta):
	#var pos = player.global_position - Vector2(0, 16)
	#var x = floor(pos.x / 320) * 320
	#var y = floor(pos.y / 180) * 180
	#global_position = Vector2(x, y)
	pass

func body_entered(body):
	if body.get('type') == 'enemy':
		body.add_to_group('enemies-in-scene')
		body.set_physics_process(true)
		
func body_exited(body):
	if body.get('type') == 'enemy':
		body.set_physics_process(false)

func area_exited(area):
	if area.get('disappears') == true:
		area.queue_free()
