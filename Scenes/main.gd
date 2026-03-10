extends Control

@export var clients_a_day: int = 5
@export var total_days: int = 7

@onready var client_display : Node2D = %ClientDisplay

var total_number_of_clients: int = 0
var bouquets_made: int = 0
var days_past: int = 0
var game_over_scene = preload("res://Scenes/game_over.tscn").instantiate()


func _ready():
	Globals.main = self
	print("Start Game")
	total_number_of_clients = len(Globals.characters)
	print("Total number of clients: ", total_number_of_clients)
	Globals.clients_a_day = clients_a_day
	Globals.total_days = total_days
	$IncorrectOrder.hide()

func _process(delta):
	pass

func _on_give_button_pressed():
	if Globals.use_jon_short_version:
		var bouquet_type = BouquetHelpers.get_bouquet_type(Globals.get_current_arrangement_flower_resources())
		BouquetHelpers.get_bouquet_name(bouquet_type)
		if !Globals.characters[Globals.current_character].bouquet == bouquet_type and !Input.is_action_pressed("debug_skip"):
			$AnimationPlayer.play("flash_incorrect")
			return
	
	if Globals.use_jon_short_version:
		Globals.current_character += 1
		if Globals.current_character == 6:
			$EndDisplay.show()
			return
	else:
		var bouquet_type = BouquetHelpers.get_bouquet_type(Globals.get_current_arrangement_flower_resources())
		var flowers_used_on_client = len(Globals.get_current_arrangement_flower_resources())
		if Globals.day == -1:
			if Globals.characters[Globals.current_character].bouquet == bouquet_type or Input.is_action_pressed("debug_skip"):
				Globals.current_character = (Globals.current_character + 1) % len(Globals.characters)
				if Globals.current_character == 6:
					handle_day_end()
		else:
			var has_bouquet : bool = false
			var has_flowers : int = 0
			var required_flowers : int = 0
			var response : String = "bad"
			
			if BouquetHelpers.get_bouquet_name(bouquet_type) == Globals.random_selected_character["bouquet_request"]:
				has_bouquet = true
				response = "meh"
			
			for flower in Globals.random_selected_character["flower_requests"]:
				required_flowers += 1
				if BouquetHelpers.has_flower(flower, Globals.get_current_arrangement_flower_resources()):
					has_flowers += 1
					response = "meh"
			
			if has_bouquet and has_flowers == required_flowers:
				response = "good"
			print("moneyb4", Globals.money)
			Globals.money += (Globals.random_selected_character["price"] * 0.5) if has_bouquet else 0.0
			print("money3r", Globals.money)
			if required_flowers > 0:
				Globals.money += Globals.random_selected_character["price"] * 0.5 * (float(has_flowers) / float(required_flowers))
			else:
				Globals.money += (Globals.random_selected_character["price"] * 0.5) if has_bouquet else 0.0
			
			print("money8r", Globals.money, " ", Globals.random_selected_character["price"] * 0.5 * (float(has_flowers) / float(required_flowers)))
			match response:
				"good":
					await client_display.run_response(Globals.random_selected_character["success_response"], response)
				
				"bad":
					await client_display.run_response(Globals.random_selected_character["failiure_response"], response)
				
				"meh":
					await client_display.run_response(Globals.random_selected_character["meh_response"], response)
					
			if response != "bad":
				print("Flowers used: ", flowers_used_on_client)
				Globals.flowers_a_day += flowers_used_on_client
	
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.clear_flowers()
	$FlowerUI/SideBouquet.clear_flowers()

func handle_day_end():
	# Spend money for flowers and get money for bouquet
	Globals.money -= Globals.bouquet_cost
	Globals.money += Globals.total_value
	# TODO: get bonus money
	var day_ended = false
	bouquets_made += 1
	#if _is_day_over():
		##get_tree().root.add_child(game_over_scene)
		#days_past += 1
		#day_ended = true
	#if _is_game_over():
		#get_tree().root.add_child(game_over_scene)
		#return
	#if day_ended:
		#_end_day()
	$ClientDisplay._display_current_client()
	$FlowerUI/Arrangement.return_flowers()
	$FlowerUI/SideBouquet.clear_flowers()

func _end_day() -> void:
	Globals.end_day()
	
func _is_day_over() -> bool:
	#print("bouquets_made: ", bouquets_made)
	return bouquets_made % clients_a_day == 0

func _is_game_over() -> bool:
	return days_past >= total_days

func _on_reset_flowers_pressed():
	$FlowerUI/Arrangement.return_flowers()
	$FlowerUI/SideBouquet.clear_flowers()
