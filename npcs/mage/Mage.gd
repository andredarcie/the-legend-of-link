class_name Mage extends Node2D

var dialogBox: DialogBox = null
var characterName = 'Old Mage'
var dialogs = ["Welcome to this incredible adventure!","This is the way."]

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if (body as Player).keys > 0:
		dialogBox.start_dialog(self.characterName, [
			'Haha! You got the key!'
		])
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
