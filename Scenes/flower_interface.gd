extends Control

func _process(delta):
	if Globals.selected_flower != null:
		$SelectedFlower.texture = Globals.selected_flower
		$SelectedFlower.position = get_local_mouse_position()
