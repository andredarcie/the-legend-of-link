class_name Entity extends KinematicBody2D

const MAXHEALTH = 2

var speed = 70
var movedir = Vector2(0, 0)
var knockdir = Vector2(0, 0)
var spritedir = 'down'
var hitstun = 0
var health = MAXHEALTH
var type = 'enemy'
var texture_default = null
var texture_hurt = null

func _ready():
	if type == 'enemy':
		set_physics_process(false)
		
	texture_default = $Sprite.texture
	print($Sprite.texture.get_path())
	texture_hurt = load($Sprite.texture.get_path().replace('.png','_hurt.png'))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed
	else:
		motion = knockdir.normalized() * 125
		
	move_and_slide(motion, Vector2(0, 0))
	
func spriterdir_loop():
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

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if type == 'enemy' && health <= 0:
			var death_animation = preload("res://enemies/enemy_death.tscn").instance()
			.get_parent().add_child(death_animation)
			death_animation.global_transform = global_transform
			.queue_free()
		
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get('damage') != null and body.get('type') != type:
			health -= body.get('damage')
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)

	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
