extends Control

@onready var page_anims: AnimationPlayer = $Page
@onready var page_left: MarginContainer = %PageLeft
@onready var page_right: MarginContainer = %PageRight

var current_page : int = 0
var shown : bool = false

func _ready() -> void:
	Globals.book = self
	hide()

func show_book():
	switch_page(0, false)
	page_anims.play("pull_up")
	show()
	shown = true


func hide_book():
	switch_page(0, false)
	page_anims.play_backwards("pull_up")
	await page_anims.animation_finished
	hide()
	shown = false


func turn_to_page(page : int):
	switch_page(0, false)
	page_anims.play("pull_up")
	await page_anims.animation_finished
	if page == 0: return
	for i in range(1, page + 1):
		await switch_page(i)
	
func switch_page(page : int, animate : bool = true):
	if animate: page_anims.play("turn")
	for child in page_left.get_children() + page_right.get_children():
		visible = child.name == str(page)
	
	current_page = page
	if animate:
		await page_anims.animation_finished


func _on_close_pressed() -> void:
	hide_book()
