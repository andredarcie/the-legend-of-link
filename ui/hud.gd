class_name Hud extends CanvasLayer

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8

var old_max_health

func _ready() -> void:
	old_max_health = GameState.player_max_health
	for i in GameState.player_max_health:
		add_new_heart()
		

func add_new_heart():
	var new_heart = Sprite.new()
	new_heart.texture = $hearts.texture
	new_heart.hframes = $hearts.hframes
	$hearts.add_child(new_heart)
	
	
func _process(_delta: float) -> void:
	if old_max_health != GameState.player_max_health:
		old_max_health = GameState.player_max_health
		add_new_heart()
		
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(GameState.player_health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (GameState.player_health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
			
	show_coins()
	show_keys()
	show_arrows()
	
	
func show_coins():
	$VBoxContainer/CoinTextLabel.text = "coins: " + str(GameState.coins)
	
func show_keys():
	$VBoxContainer/KeysTextLabel.text = "keys: " + str(GameState.keys)
	
func show_arrows():
	$VBoxContainer2/ArrowTextLabel.text = "arrows: " + str(GameState.player_arrows)
