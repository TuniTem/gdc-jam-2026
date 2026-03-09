extends Node2D

const DEBUG = true

var selected_flower = null
var selected_flower_res = null
var characters = null
var current_character = 0
var flower_center_pos = Vector2(1329, 737)
var unlocks : Array[Entry]
var book : Control
var money: int = 0

func unlock_entry(id : String):
	for unlock in unlocks:
		if unlock.unlock_id == id:
			await book.turn_to_page(unlock.page)
			unlock.animation.play("paint_in")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug") and DEBUG:
		unlock_entry("test")
