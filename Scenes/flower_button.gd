extends TextureButton

func _on_pressed():
	Globals.selected_flower = texture_normal
	get_tree().call_group("flower_interface", "reset_flower_rotation")
