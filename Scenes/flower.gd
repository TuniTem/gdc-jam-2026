extends Node2D
class_name Flower

const MIN_MOVE = 5.0
var radius : float = 200.0

func move(amount : Vector2, delta : float):
	if amount.length() > MIN_MOVE * delta:
		position += amount

func set_texture(texture):
	$PlaceholderFlower1.texture = texture
