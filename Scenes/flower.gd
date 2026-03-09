extends Node2D
class_name Flower

const MIN_MOVE = 5.0

const MAX_STEM_DIST = 400.0

var flower_res = null

@export var radius : float = 60.0
var stem_pos : Vector2

func _process(delta: float) -> void:
	queue_redraw()

func move(amount : Vector2, delta : float):
	if amount.length() > MIN_MOVE * delta:
		position += amount
		var stem_direction : Vector2 = position - stem_pos
		position = stem_pos + (clamp(stem_direction.length(), 0.0, MAX_STEM_DIST) * stem_direction.normalized())

func set_texture(texture):
	$PlaceholderFlower1.texture = texture
