extends Control

@export var clients_a_day: int = 5
@export var total_days: int = 7

var total_number_of_clients: int = 0
var bouquets_made: int = 0
var days_past: int = 0
var game_over_scene = preload("res://Scenes/game_over.tscn").instantiate()


func _ready():
	print("Start Game")
	total_number_of_clients = len(Globals.characters)
	print("Total number of clients: ", total_number_of_clients)
	Globals.clients_a_day = clients_a_day
	Globals.total_days = total_days
	
func _on_give_button_pressed():
	Globals.current_character = (Globals.current_character + 1) % len(Globals.characters)
	# Spend money for flowers and get money for bouquet
	Globals.money -= Globals.bouquet_cost
	Globals.money += Globals.total_value
	# TODO: get bonus money
	var day_ended = false
	bouquets_made += 1
	if _is_day_over():
		#get_tree().root.add_child(game_over_scene)
		days_past += 1
		day_ended = true
	if _is_game_over():
		get_tree().root.add_child(game_over_scene)
		return
	if day_ended:
		_end_day()
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.clear_flowers()
	$FlowerUI/SideBouquet.clear_flowers()

func _end_day() -> void:
	Globals.end_day()
	
func _is_day_over() -> bool:
	#print("bouquets_made: ", bouquets_made)
	return bouquets_made % clients_a_day == 0

func _is_game_over() -> bool:
	return days_past >= total_days
