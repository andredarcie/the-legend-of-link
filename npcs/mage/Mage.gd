class_name Mage extends Node2D

var dialogBox: DialogBox = null
var characterName = 'Uncle Bob'
var dialogs = ["Aperte a tecla X e descubra","Mas se não for desistir siga esse [wave]caminho."]
var talkAboutTheKey = false

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if not body.get('type') == "player":
		return
		
	if self.talkAboutTheKey:
		dialogBox.start_dialog(self.characterName, [
			'Sentido-se perdido?'
		])
		return
		
	if GameState.keys > 0:
		dialogBox.start_dialog(self.characterName, [
			'Haha! Você encontrou a maldita chave.'
		])
		self.talkAboutTheKey = true
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
