extends Camera2D

func _ready():
	$area.connect('body_entered', self, 'body_entered')
	$area.connect('body_exited', self, 'body_exited')
	$area.connect('area_exited', self, 'area_exited')
	
func _process(delta):
	var pos = get_node('../player').global_position - Vector2(0, 16)
	var x = floor(pos.x / 256) * 256
	var y = floor(pos.y / 224) * 224
	global_position = Vector2(x, y)

func body_entered(body):
	if body.get('type') == 'enemy':
		body.set_physics_process(true)
		
func body_exited(body):
	if body.get('type') == 'enemy':
		body.set_physics_process(false)

func area_exited(area):
	if area.get('disappears') == true:
		area.queue_free()
