class_name Hud extends CanvasLayer

onready var player: Node2D = get_node('../player')

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8

func _ready() -> void:
	for i in player.MAXHEALTH:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)

func _process(_delta: float) -> void:
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(player.health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (player.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
			
	$keys.frame = player.keys

func showDialog():
	$DialogBox/RichTextLabel.start_dialog()

func hideDialog():
	$DialogBox/RichTextLabel.end_dialog()
