extends Node2D

var player

func _ready():
	player = get_node('../player')

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var x = player.position.distance_to(self.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
