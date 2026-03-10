extends Node2D

const DEBUG = true
const CLIENT_DIALOG_PATH = "res://resources/ClientDialogs.json"

var selected_flower = null
var selected_flower_res = null
var characters = null
var current_character = 0
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

@export var flower_to_count_map: Dictionary[Resource, int] = {}
var flowers_unlocked = 3

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
	flower_to_count_map[load("res://resources/ButterFlower.tres")] = 15
	# flower_to_count_map[load("res://resources/CactusFlower.tres")] = 30
	flower_to_count_map[load("res://resources/DevilsFlower.tres")] = 0
	flower_to_count_map[load("res://resources/IceFlower.tres")] = 0
	
	flower_to_count_map[load("res://resources/FireworkFlower.tres")] = 0
	flower_to_count_map[load("res://resources/SilkweedFlower.tres")] = 15
	
	flower_to_count_map[load("res://resources/NectarFlower_1.tres")] = 15
	flower_to_count_map[load("res://resources/NectarFlower_2.tres")] = 0
	flower_to_count_map[load("res://resources/NectarFlower_3.tres")] = 0
	flower_to_count_map[load("res://resources/SpikeFlower.tres")] = 0

func unlock_entry(id : String):
	for unlock in unlocks:
		if unlock.unlock_id == id:
			await book.turn_to_page(unlock.page)
			unlock.animation.play("paint_in")

func end_day():
	day_controller.start_new_day()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug") and DEBUG:
		end_day()

func get_current_arrangement_flower_resources(): 
	return get_tree().get_first_node_in_group("arrangement").get_list_of_flower_resources()

func create_custom_event(day : int):
	var file : FileAccess = FileAccess.open(CLIENT_DIALOG_PATH, FileAccess.READ)
	var event_dict : Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	
	
