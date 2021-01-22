extends Node2D

var hud = preload("res://ui/hud.tscn")

func _ready():
	add_child(hud.instance())
	
