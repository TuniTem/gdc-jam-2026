extends ImageButton




func _on_pressed() -> void:
	if Globals.book.shown:
		Globals.book.hide_book()
	
	else:
		Globals.book.show_book()
