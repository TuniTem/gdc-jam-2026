extends Node


# Load the custom images for the mouse cursor.
var arrow = load("res://Assets/custom_pointer.png")
var closed_hand_cursor = load("res://Assets/closed_hand.png")
var open_hand_cursor = load("res://Assets/open_hand.png")

func _ready():
	# Changes the arrow shape of the cursor.
	# This is also done in the project settings.
	Input.set_custom_mouse_cursor(arrow)

	# Changes a specific shape of the cursor
	Input.set_custom_mouse_cursor(open_hand_cursor, Input.CURSOR_POINTING_HAND)

func _process(delta: float) -> void:
	if  Globals.hand_closed:
		Input.set_custom_mouse_cursor(closed_hand_cursor)
		Input.set_custom_mouse_cursor(closed_hand_cursor, Input.CURSOR_POINTING_HAND)
	else:
		Input.set_custom_mouse_cursor(arrow)		
		Input.set_custom_mouse_cursor(open_hand_cursor, Input.CURSOR_POINTING_HAND)
