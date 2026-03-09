extends Node2D

func _on_give_button_pressed():
	Globals.current_character += 1
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.clear_flowers()
	$FlowerUI/SideBouquet.clear_flowers()
