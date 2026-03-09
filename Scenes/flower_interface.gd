extends Control

func _process(delta):
	if Globals.selected_flower != null:
		$SelectedFlower.texture = Globals.selected_flower_res.flower_texture
		$SelectedFlower.position = get_global_mouse_position()
	if Input.is_action_just_pressed("mouse_right") and Globals.selected_flower != null:
		deselect_flower()
	if Input.is_action_just_pressed("cancel") and Globals.selected_flower != null:
		deselect_flower()
	if Input.is_action_just_pressed("mouse_left") and get_global_mouse_position().distance_to($DrawableArea.position) > 500:
		deselect_flower()
	if Input.is_action_pressed("rotate_right"):
		$SelectedFlower.rotate(1.0 * delta)
	if Input.is_action_pressed("rotate_left"):
		$SelectedFlower.rotate(-1.0 * delta)

func reset_flower_rotation():
	$SelectedFlower.rotation = 0

func deselect_flower():
	$SelectedFlower.texture = null
	Globals.selected_flower = null
	Globals.selected_flower_res = null
