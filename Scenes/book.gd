extends Control

const NUMBER_PAGES = 2

@onready var page_anims: AnimationPlayer = $Page
@onready var page_left: MarginContainer = %PageLeft
@onready var page_right: MarginContainer = %PageRight
@onready var next_page: ImageButton = %NextPage
@onready var previous_page: ImageButton = %PreviousPage

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
	print("hide_book")
	print_stack()
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
		child.visible = child.name == str(page)
	
	current_page = page
	if animate:
		await page_anims.animation_finished


func _on_close_pressed() -> void:
	hide_book()
	print("colose")
	


func _on_previous_page_pressed() -> void:
	print("prev")
	if current_page > 0:
		current_page -= 1
		switch_page(current_page)
	
	next_page.visible = current_page < NUMBER_PAGES - 1
	previous_page.visible = current_page > 0


func _on_next_page_pressed() -> void:
	print("next")
	if current_page < NUMBER_PAGES - 1:
		current_page += 1
		switch_page(current_page)
	
	next_page.visible = current_page < NUMBER_PAGES - 1
	previous_page.visible = current_page > 0
