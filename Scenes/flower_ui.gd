extends Control

@onready var money_label: Label = %MoneyLabel

func _process(delta):
	$ValidCircle.queue_redraw()


func _on_book_button_pressed() -> void:
	if Globals.book.shown:
		Globals.book.hide_book()
	else:
		Globals.book.show_book()
