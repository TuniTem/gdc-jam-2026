extends Control

func _ready():
	$RefImage.hide()

func add_flower(flower_res):
	var next_sprite = $RefImage.duplicate()
	$Flowers.add_child(next_sprite)
	next_sprite.show()
	next_sprite.texture = flower_res.side_texture
	next_sprite.position = $Pivot.position
	if randi() % 2 == 0:
		next_sprite.rotation = deg_to_rad(randf_range(-50, -10))
	else:
		next_sprite.rotation = deg_to_rad(randf_range(10, 50))
