extends Control

func _on_give_button_pressed():
	Globals.current_character += 1
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.clear_flowers()
	$FlowerUI/SideBouquet.clear_flowers()
	# Spend money for flowers and get money for bouquet
	# TODO: get bonus money
	Globals.money -= Globals.bouquet_cost
	Globals.money += Globals.total_value
