extends CanvasLayer

func _process(delta):
	$keys.frame = get_node('../player').keys
