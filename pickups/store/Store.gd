extends Node2D

onready var key_texture = load("res://pickups/key/key.png")
onready var heart_texture = load("res://pickups/heart/heart.png")
onready var heart_container_texture = load("res://pickups/heart/heart_container.png")

onready var ballon_texture = load("res://pickups/store/ballon.png")

enum ITEMS {
	key,
	heart,
	heart_container
}

export(ITEMS) var item1_type
export(int) var item1_value = 10
export(ITEMS) var item2_type
export(int) var item2_value = 20
export(ITEMS) var item3_type
export(int) var item3_value = 30

var salesman_is_dead = false

func _ready():
	show_all_items()
	
	
func show_all_items():
	set_item($Item1, item1_type, item1_value)
	set_item($Item2, item2_type, item2_value)
	set_item($Item3, item3_type, item3_value)
	
	
func set_item(item, item_type, value):
	item.get_node("Sprite").texture = get_item_texture(item_type)
	item.get_node("Sprite/RichTextLabel").text = str(value)


func get_item(item, type, value, body):
	if body.get("type") != null:
		if body.type == "player" and GameState.coins >= value:
			item.queue_free()
			GameState.coins -= value
			
			if type == ITEMS.key:
				GameState.keys += 1
			elif type == ITEMS.heart:
				GameState.player_health += 1
			elif type == ITEMS.heart_container:
				body.gain_max_health(1)
			
			if not salesman_is_dead:
				$Salesman/Balloon.texture = ballon_texture
				$Salesman/SalesmanHappyTimer.start()
		else:
			item.get_node("Sprite/RichTextLabel").bbcode_enabled = true
			item.get_node("Sprite/RichTextLabel").bbcode_text = "[color=#e74c3c]%s[/color]" % value


func get_item_texture(item) -> Texture:
	if item == ITEMS.key:
		return key_texture
	elif item == ITEMS.heart:
		return heart_texture
	elif item == ITEMS.heart_container:
		return heart_container_texture
	
	return Texture.new()


func _on_Item1_body_entered(body):
	get_item($Item1, item1_type, item1_value, body)


func _on_Item2_body_entered(body):
	get_item($Item2, item2_type, item2_value, body)


func _on_Item3_body_entered(body):
	get_item($Item3, item3_type, item3_value, body)


func _on_Item1_body_exited(_body):
	if salesman_is_dead:
		return
		
	$Item1/Sprite/RichTextLabel.bbcode_text = "[color=white]%s[/color]" % item1_value


func _on_Item2_body_exited(_body):
	if salesman_is_dead:
		return
		
	$Item2/Sprite/RichTextLabel.bbcode_text = "[color=white]%s[/color]" % item2_value


func _on_Item3_body_exited(_body):
	if salesman_is_dead:
		return
		
	$Item3/Sprite/RichTextLabel.bbcode_text = "[color=white]%s[/color]" % item3_value


func _on_Salesman_area_entered(area):
	if area.get_parent().name == "sword":
		salesman_is_dead = true
		item1_value = 0
		item2_value = 0
		item3_value = 0
		
		if $Item1 != null:
			$Item1/Coin.queue_free()
			$Item1/Sprite/RichTextLabel.queue_free()
			
		if $Item2 != null:
			$Item2/Coin2.queue_free()
			$Item2/Sprite/RichTextLabel.queue_free()
			
		if $Item3 != null:
			$Item3/Coin3.queue_free()
			$Item3/Sprite/RichTextLabel.queue_free()
			
		$Salesman.queue_free()


func _on_SalesmanHappyTimer_timeout():
	if $Salesman != null:
		$Salesman/Balloon.texture = Texture.new()
		$Salesman/SalesmanHappyTimer.stop()
