extends StaticBody2D

func _ready():
	$area.connect('body_entered', self, 'body_entered')

func body_entered(body):
	if body.name == 'player' && GameState.keys > 0:
		GameState.keys -= 1
		queue_free()
