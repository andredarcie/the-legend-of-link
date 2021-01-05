class_name Mage extends Node2D

var hud: Hud = null

func _ready():
	hud = get_tree().get_root().find_node("hud", true, false) as Hud


func _on_Area2D_body_entered(body):
	hud.showDialog()


func _on_Area2D_body_exited(body):
	hud.hideDialog()
