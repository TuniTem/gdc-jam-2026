extends Control

func _ready():
	$ColorRect.hide()
	$RefImage.hide()

func add_flower(flower_res):
	var next_sprite : Sprite2D = $RefImage.duplicate()
	$Flowers.add_child(next_sprite)
	next_sprite.show()
	next_sprite.texture = flower_res.side_texture
	next_sprite.position = $Pivot.position + Vector2(randf_range(-2, 2), randf_range(-2, 2))
	if randi() % 2 == 0:
		next_sprite.rotation = deg_to_rad(randf_range(-50, -10))
	else:
		next_sprite.rotation = deg_to_rad(randf_range(10, 50))
	next_sprite.z_index = randi() % 50

func clear_flowers():
	for flower in $Flowers.get_children():
		flower.queue_free()
