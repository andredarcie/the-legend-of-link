class_name DialogBox extends Polygon2D	
	
func start_dialog(name: String, dialogs):
	$TextName.set_name(name + ': ')
	$TextBox.start_dialog(dialogs)
	
func end_dialog():
	$TextBox.end_dialog()
