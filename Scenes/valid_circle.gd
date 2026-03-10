extends Control

@export var drawable_area : Marker2D = null

func _draw():
	if Globals.selected_flower != null:
		draw_circle(drawable_area.position, Globals.PLACEABLE_DIST, Color(.5, .5, .5, .25), true)
