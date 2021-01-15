extends Navigation2D

onready var player := $"../player" as Player
onready var follower := $"../Follower" as Follower
var paths: PoolVector2Array
var follow: bool = false

func _ready():
	pass
	

func _on_player_player_move():
	if follow:
		for enemy in get_tree().get_nodes_in_group("enemies-in-scene"):
			var start = enemy.global_position
			var end = player.global_position
			self.paths = get_simple_path(start, end)
			#$Line2D.points = self.paths
			enemy.path = self.paths
