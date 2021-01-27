extends Area2D

var dialogBox: DialogBox = null
export var message = ''

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox


func _on_Board_body_entered(body):
	if body.get("type") == null:
		return 
		
	dialogBox.start_dialog("Board", [
		message
	])


func _on_Board_body_exited(body):
	dialogBox.end_dialog()
