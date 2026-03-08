extends Node

# Preload the texture resource for better performance
const CLIENT_TEXTURE: Texture2D = preload("res://Assets/bad-placeholder-human.png")


func _ready():
	# Reference the TextureRect node
	var texture_rect_node = $CanvasLayer/TextureRect
	texture_rect_node.texture = CLIENT_TEXTURE
	# call_deferred("_assign_char_texture")

func _assign_char_texture():
	$TextureRect.texture = load("res://Assets/bad-placeholder-human.png")
