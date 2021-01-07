class_name Entity extends KinematicBody2D

var MAXHEALTH: int = 2

var speed: float = 70
var movedir: Vector2 = Vector2(0, 0)
var knockdir: Vector2 = Vector2(0, 0)
var spritedir: String = 'down'
var hitstun: int = 0
var health: int = MAXHEALTH
var type: String = 'enemy'
var texture_default: Texture = null
var texture_hurt: Texture = null

func _ready() -> void:
	if type == 'enemy':
		set_collision_mask_bit(1, 1)
		set_physics_process(false)
		
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace('.png','_hurt.png'))

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
	health = min(MAXHEALTH, health)
	
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
		if hitstun == 0 and body.get('damage') != null and body.get('type') != type:
			health -= body.get('damage')
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

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
