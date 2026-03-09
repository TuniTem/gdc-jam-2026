extends Control

func _process(delta):
	queue_redraw()

func _draw():
	if Globals.selected_flower != null:
		draw_circle($DrawableArea.position, 500, Color(.5, .5, .5, .5), true)
