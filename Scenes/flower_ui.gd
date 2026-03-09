extends Control

@onready var money_label: Label = %MoneyLabel

func _process(delta):
	$ValidCircle.queue_redraw()
