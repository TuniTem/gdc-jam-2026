extends Node

# Preload the texture resource for better performance
const CLIENT_TEXTURE: Texture2D = preload("res://Assets/bad-placeholder-human.png")

func _display_current_client():
	var texture_rect_node = $CanvasLayer/TextureRect
	texture_rect_node.texture = Globals.characters[Globals.current_character].portrait


func _ready():
	$ClientOrders._populate()
	_display_current_client()

func _assign_char_texture():
	$TextureRect.texture = load("res://Assets/bad-placeholder-human.png")
