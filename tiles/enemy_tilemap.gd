extends TileMap

func _ready() -> void:
	var size = get_cell_size()
	var offset = size / 2
	
	for tile in get_used_cells():
		var name = get_tileset().tile_get_name(get_cell(tile.x, tile.y))
		var node = load(str('res://enemies/', name, '.tscn')).instance()
		node.global_position = tile * size + offset
		get_parent().call_deferred('add_child', node)
	queue_free()
