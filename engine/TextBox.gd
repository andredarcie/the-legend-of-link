class_name TextBox extends RichTextLabel

var dialog =  []
var page: int = 0

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		
		if page == dialog.size() - 1:
			set_visible(false)
			return
		
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size() - 1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	
func set_visible(flag: bool):
	get_owner().visible = flag
	
func start_dialog(dialogs):
	dialog = dialogs
	page = 0
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	set_visible(true)

func end_dialog():
	set_visible(false)
