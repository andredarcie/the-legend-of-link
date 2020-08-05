extends KinematicBody2D

var speed = 70
var movedir = Vector2(0, 0)
var knockdir = Vector2(0, 0)
var spritedir = 'down'
var hitstun = 0
var health = 1
var type = 'enemy'

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed
	else:
		motion = knockdir.normalized() * speed * 1.5
		
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
