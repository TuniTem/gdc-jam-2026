extends Node2D

const DEBUG = true
var use_jon_short_version = false

const PLACEABLE_DIST = 400
const CLIENT_DIALOG_PATH = "res://resources/ClientDialogs.json"

var selected_flower = null
var selected_flower_res = null
var characters = null
var current_character = 0

var random_selected_character : Dictionary
var clients : Node
var arrangement 

var flower_center_pos = Vector2(1329, 737)
var unlocks : Array[Entry]
var book : Control
var money: int = 0
var bouquet_cost: int = 0
var customer_budjet: int = 0
var total_value: int = 0
var popularity: int = 0
var day : int = 0
var day_controller : DayController
var clients_a_day: int = 0
var total_days: int = 0
var flowers_a_day: int = 0
var money_a_day: int = 0
var starting_money: int = 0
var main : Control
var hand_closed: bool = false

@export var flower_to_count_map: Dictionary[String, int] = {}
var flowers_unlocked = 3

var clients_left : int = 4
const CLIENTS_PER_DAY = [4, 6]


var day_end_stats : Dictionary = {
	"people_helped": 0,
	"flowers_used" : 0,
	"money_made" : 0,
	"start_popularity" : 0.0,
	"current_popularity" : 0.0
}

func _ready():
	# flower_to_count_map[load("res://resources/PurpleFlower.tres")] = 30
	# flower_to_count_map[load("res://resources/AquaFlower.tres")] = 30
	for flower in FLOWERS.keys():
		flower_to_count_map[flower] = 7
	# flower_to_count_map[load("res://resources/CactusFlower.tres")] = 30
	
	for flower in FLOWERS.keys():
		if FLOWERS[flower].flower_type != Enums.FlowerType.UNUSED:
			base_price[FLOWERS[flower].flower_type] = min(base_price[FLOWERS[flower].flower_type], FLOWERS[flower].flower_cost)

func unlock_entry(id : String):
	for unlock in unlocks:
		if unlock.unlock_id == id:
			await book.turn_to_page(unlock.page)
			unlock.animation.play("paint_in")

func end_day():
	print("end day")
	money_a_day = money - starting_money
	#day_end_stats["people_helped"] = clients_a_day
	day_end_stats["flowers_used"] = flowers_a_day
	flowers_a_day = 0
	day_end_stats["money_made"] = money_a_day
	day_controller.start_new_day()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug") and DEBUG:
		end_day()

func get_current_arrangement_flower_resources(): 
	return get_tree().get_first_node_in_group("arrangement").get_list_of_flower_resources()


var base_price : Dictionary[Enums.FlowerType, int] = {
	Enums.FlowerType.FOCAL : 5,
	Enums.FlowerType.FOLIAGE : 2,
	Enums.FlowerType.FILLER : 4
}

const COMPLIMENT_CHANCE = 5 # /10
var BOUQUETS : Dictionary[String, Dictionary] = {
	"barthemelo": {
		Enums.FlowerType.FOCAL : 3,
		Enums.FlowerType.FOLIAGE : 2,
		Enums.FlowerType.FILLER : 6
	},
	"lazy_eye": {
		Enums.FlowerType.FOCAL : 2,
		Enums.FlowerType.FOLIAGE : 4,
		Enums.FlowerType.FILLER : 6
	},
	"expedition": {
		Enums.FlowerType.FOCAL : 1,
		Enums.FlowerType.FOLIAGE : 3,
		Enums.FlowerType.FILLER : 3
	},
	"six_pin": {
		Enums.FlowerType.FOCAL : 6,
		Enums.FlowerType.FOLIAGE : 2,
		Enums.FlowerType.FILLER : 0
	},
	"grasshopper": {
		Enums.FlowerType.FOCAL : 0,
		Enums.FlowerType.FOLIAGE : 7,
		Enums.FlowerType.FILLER : 1
	},
	"four_pence": {
		Enums.FlowerType.FOCAL : 4,
		Enums.FlowerType.FOLIAGE : 6,
		Enums.FlowerType.FILLER : 0
	}
}

const NAMES : Dictionary = {
	"male": [
		"John",
	],
	"female": [
		"Jane",
	]
}

const PICS : Dictionary = {
	"male": [
		preload("res://sprites/characters/char-0.png"),
		preload("res://sprites/characters/char-1.png"),
		preload("res://sprites/characters/char-2.png"),
		preload("res://sprites/characters/char-4.png")
	],
	"female": [
		preload("res://sprites/characters/char-3.png"),
		preload("res://sprites/characters/char-5.png")
	]
}

const FLOWERS : Dictionary[String, Resource] = {
	"aqua" : preload("res://resources/AquaFlower.tres"),
	"butter_lilly": preload("res://resources/ButterFlower.tres"),
	"devils_pitchfork": preload("res://resources/DevilsFlower.tres"),
	"crystal_heart": preload("res://resources/SpikeFlower.tres"),
	"sky_bloom": preload("res://resources/IceFlower.tres"),
	"nectar_red": preload("res://resources/NectarFlower_1.tres"),
	"nectar_green": preload("res://resources/NectarFlower_2.tres"),
	"nectar_purple": preload("res://resources/NectarFlower_3.tres"),
	"filigree": preload("res://resources/FireworkFlower.tres"),
	"silkweed": preload("res://resources/SilkweedFlower.tres")
}

const DIFFICULTY_UPGRADE_CHANCE_CURVE = 0.75
const PER_DAY_MULT = 1.1
const COMMISSION_BASE_MULT = [1.25, 1.75]
const COMMISSION_REQUEST_MULT = [1.1, 1.2]

func generate_new_character():
	clients_left -= 1
	print("clients left: ", clients_left)
	if clients_left != 0:
		day_end_stats["people_helped"] += 1
		SFX.play("customer")
		random_selected_character = create_custom_chracter(day)
		return true
	else:
		clients_left = randi_range(CLIENTS_PER_DAY[0], CLIENTS_PER_DAY[1])
		end_day()
		return false
		

func create_custom_chracter(day : float) -> Dictionary:
	var file : FileAccess = FileAccess.open(CLIENT_DIALOG_PATH, FileAccess.READ)
	var event_dict : Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	
	var greeting : String = event_dict["greetings"].pick_random()
	var compliment : String = ""
	if randi_range(1, 10) <= COMPLIMENT_CHANCE:
		compliment = event_dict["intro_comments"].pick_random()
	
	var ending_commnet : String = event_dict["end_comments"].pick_random()
	var success_response : String = event_dict["successful_response"].pick_random()
	var meh_response : String = event_dict["bare_minimum_response"].pick_random()
	var failiure_response : String = event_dict["failure_response"].pick_random()
	
	var difficulty : int = 0
	
	# Taken from factorios biter evolution factor eq lol
	var difficulty_increase_chance : float = 1.0 - (pow(DIFFICULTY_UPGRADE_CHANCE_CURVE, day + 1.0)) 
	print(difficulty_increase_chance)
	for i in range(3):
		if randf_range(0.0, 1.0) < difficulty_increase_chance:
			difficulty += 1
		else: 
			break
	print("scenarios ", event_dict["scenarios"].keys())
	var scenario : String = event_dict["scenarios"].keys().pick_random()
	var selected_boquet : String = BOUQUETS.keys().pick_random()
	var temp_boquet_validation : Dictionary = BOUQUETS[selected_boquet].duplicate()
	
	var prompt : String = event_dict["scenarios"][scenario]["prompt"].pick_random()
	var gender : String = "female" if randi_range(0, 1) == 1 else "male" 
	prompt = prompt.replace("[bouquet]", selected_boquet.capitalize()).replace("[name]", NAMES[gender].pick_random())
	
	var flower_requests : Array[String] = []
	var flower_request_prompt : String = ""
	var materials_cost : int = 0
	
	print("difficulty: ", difficulty)
	if difficulty != 0:
		for i in range(difficulty):
			for k in range(1000):
				var request_attempt : String = event_dict["scenarios"][scenario]["event_specific_flower_hints"].keys().pick_random()
				var type : Enums.FlowerType = FLOWERS[request_attempt].flower_type
				if temp_boquet_validation[type] > 0 and not flower_requests.has(request_attempt):
					flower_requests.append(request_attempt)
					temp_boquet_validation[type] -= 1
					materials_cost += FLOWERS[request_attempt].flower_cost
					break
		
		for flower_request : String in flower_requests:
			flower_request_prompt += " "
			flower_request_prompt += event_dict["scenarios"][scenario]["event_specific_flower_hints"][flower_request].pick_random()
	
	print("flower_requests", flower_requests)
	for type : Enums.FlowerType in [Enums.FlowerType.FOCAL, Enums.FlowerType.FOLIAGE, Enums.FlowerType.FILLER]:
		materials_cost += base_price[type] * temp_boquet_validation[type]
	var final_dialog : String = greeting + (" " if compliment != "" else "") + "\n\n" + compliment + " " + prompt + (" " if flower_request_prompt != "" else "") + flower_request_prompt + " \n\n" + ending_commnet
	
	var character_name : String = NAMES[gender].pick_random()
	var character_pic : Texture = PICS[gender].pick_random()
	
	var comission_amount : int = materials_cost * Util.randf_array(COMMISSION_BASE_MULT)
	for flower_request in flower_requests:
		comission_amount *= Util.randf_array(COMMISSION_REQUEST_MULT)
	print("commission amnt", comission_amount)
	
	
	return {
		"name": character_name,
		"picture" : character_pic,
		"bouquet_request" : selected_boquet,
		"flower_requests" : flower_requests,
		"dialog" : final_dialog,
		"price" : comission_amount,
		"success_response": success_response,
		"meh_response": meh_response,
		"failiure_response": failiure_response
	}
