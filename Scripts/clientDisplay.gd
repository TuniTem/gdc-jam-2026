extends Node

# Preload the texture resource for better performance
const CLIENT_TEXTURE: Texture2D = preload("res://Assets/bad-placeholder-human.png")

@onready var texture_rect_node = %TextureRect
@onready var dialog: RichTextLabel = %Dialog
@onready var name_label: Label = %Name
@onready var intro: AnimationPlayer = %intro
@onready var commission: Label = %Commission

func _display_current_client():
	load_new_client()
	return
	#if Globals.day == 0:
	intro.play("text")
	texture_rect_node.texture = Globals.characters[Globals.current_character].portrait
	$TextBox.add_text(Globals.characters[Globals.current_character].lines)
	$TextBox.set_deferred("scroll_vertical", 1000)

func load_new_client():
	if not Globals.generate_new_character(): return
	texture_rect_node.texture = Globals.random_selected_character["picture"]
	dialog.text = Globals.random_selected_character["dialog"]
	name_label.text = Globals.random_selected_character["name"]
	commission.text = "Commission: $" + str(Globals.random_selected_character["price"])
	intro.play("text")
	await Util.wait(2.0)
	SFX.play("talk")


func run_response(text : String, response : String):
	match response:
		"good":
			texture_rect_node.modulate = Color.GREEN
		"bad":
			texture_rect_node.modulate = Color.RED
		"meh":
			texture_rect_node.modulate = Color.YELLOW
	
	Util.tween(texture_rect_node, "modulate", Color.WHITE, 0.5, Tween.EASE_OUT, Tween.TRANS_CUBIC)
	intro.play("text_only")
	SFX.play("talk")
	dialog.text = text
	await intro.animation_finished
	await Util.wait(1.0)
	intro.play_backwards("leave")
	await intro.animation_finished
	await Util.wait(randf_range(0.5, 1.5))


	# $Backing/Label.text = Globals.characters[Globals.current_character].intro_line
	# texture_rect_node.flip_h = !texture_rect_node.flip_h

func _ready():
	Globals.clients = self
	$ClientOrders._populate()
	load_new_client()

func _assign_char_texture():
	$TextureRect.texture = load("res://Assets/bad-placeholder-human.png")
