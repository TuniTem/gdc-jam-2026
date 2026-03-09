extends Node2D

func _on_give_button_pressed():
	Globals.current_character += 1
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.clear_flowers()
	$FlowerUI/SideBouquet.clear_flowers()
	# TODO: add money for boquet order amount + bonus
	Globals.money += 1

func _process(delta):
	print(Globals.get_current_arrangement_flower_resources())
