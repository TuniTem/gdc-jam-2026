extends Control

@onready var money_label: Label = $MoneyLabel

func _process(delta):
	queue_redraw()
	money_label.text = str("Money: $", Globals.money)

func _draw():
	if Globals.selected_flower != null:
		draw_circle($DrawableArea.position, 500, Color(.5, .5, .5, .5), true)
