extends Navigation2D

onready var player := $"../player" as Player
var enemies = []
var paths: PoolVector2Array
var follow: bool = true

func _ready():
	pass
	

func add_enemies(enemy):
	self.enemies.append(enemy)

func _on_player_player_move():
	return
	
	if follow:
		for enemy in enemies:
			if !enemy.get("saw_the_player"):
				continue
			
			var start = enemy.global_position
			var end = player.global_position
			enemy.path = get_simple_path(start, end)
