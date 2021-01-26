class_name Entity extends KinematicBody2D

var max_health: int = 3

var speed: float = 70
var movedir: Vector2 = Vector2(0, 0)
var knockdir: Vector2 = Vector2(0, 0)
var spritedir: String = 'down'
var hitstun: int = 0
var health: int = max_health
var type: String = 'enemy'
var texture_default: Texture = null
var texture_hurt: Texture = null

func _ready() -> void:
	if type == 'enemy':
		set_collision_mask_bit(1, 1)
		set_physics_process(false)
		
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace('.png','_hurt.png'))
	
	if type == "player":
		health = GameState.player_health
		max_health = GameState.player_max_health


func movement_loop() -> void:
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed
	else:
		motion = knockdir.normalized() * 125
		
	move_and_slide(motion, Vector2(0, 0))
	
func spriterdir_loop() -> void:
	match movedir:
		Vector2(-1, 0):
			spritedir = 'left'
		Vector2(1, 0):
			spritedir = 'right'
		Vector2(0, -1):
			spritedir = 'up'
		Vector2(0, 1):
			spritedir = 'down'

func anim_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop() -> void:
	health = min(max_health, health)
	
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if type == 'enemy' && health <= 0:
			var drop = randi() % 2
			if drop == 0:
				instance_scene(preload("res://pickups/heart.tscn"))
			instance_scene(preload("res://enemies/enemy_death.tscn"))
			queue_free()
		
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		
		if area.is_in_group("ranges"):
			continue
		
		if body.is_in_group("bullets") and not body.get("can_make_damage"):
			continue
			
		if body.is_in_group("bullets") and body.get("can_make_damage"):
			make_damage(body)
			body.queue_free()
			continue
		
		if  "Bonfire" in area.name:
			body = area
		
		if area.name == "Vision":
			continue
		
		if "Grass" in body.name:
			if body.get("on_fire"):
				make_damage(body)
		elif hitstun == 0 and body.get('damage') != null and body.get('type') != type:
			make_damage(body)


func make_damage(body):
	health -= body.get('damage')
	hitstun = 10
	knockdir = global_transform.origin - body.global_transform.origin
		
	if type == 'player':
		GameState.player_health = health
			
	if type == 'player' and health <= 0:
		GameState.restart_game()
	
	
func use_item(item: PackedScene) -> void:
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)

	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
		
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)
	
func gain_health(amount):
	if health + amount >= max_health:
		health = max_health
	else:
		health += amount
		
	if type == "player":
		GameState.player_health = health
		GameState.player_max_health = max_health
		
		
func gain_max_health(amount):
	max_health += amount
	
	if type == "player":
		GameState.player_max_health = max_health
