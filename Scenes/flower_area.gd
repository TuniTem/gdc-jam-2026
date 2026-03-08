extends ColorRect

func mouse_inside_area():
	var mouse_rect = Rect2(get_global_mouse_position(), Vector2.ZERO)
	return get_rect().encloses(mouse_rect)

func _process(delta):
	if Input.is_action_just_pressed("mouse_left") and mouse_inside_area() and Globals.selected_flower != null:
		var next_sprite = Sprite2D.new()
		next_sprite.texture = Globals.selected_flower
		add_child(next_sprite)
		next_sprite.position = get_local_mouse_position()
		Globals.selected_flower = null
