extends Control
@onready var animations: AnimationPlayer = %animations

func _ready() -> void:
	Globals.flower_ui = self
func _process(delta):
	
	$ValidCircle.queue_redraw()
	var bouquet_type = BouquetHelpers.get_bouquet_type(Globals.get_current_arrangement_flower_resources())
	if bouquet_type == Enums.BouquetType.NONE:
		$BouquetType.text = ""
	else:
		$BouquetType.text = "(" + BouquetHelpers.get_bouquet_name(bouquet_type) + ")"

func _on_book_button_pressed() -> void:
	if Globals.day_controller.visible: return
	
	if Globals.book.shown:
		Globals.book.hide_book()
	else:
		Globals.book.show_book()
