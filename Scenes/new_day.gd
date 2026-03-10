extends Control
class_name DayController

enum Stage {
	START,
	STATS,
	CATALOG,
	END
}

@onready var people_helped_number: Label = %PeopleHelpedNumber
@onready var flowers_used_number: Label = %FlowersUsedNumber
@onready var money_made_number: Label = %MoneyMadeNumber
@onready var popularity_change_number: Label = %PopularityChangeNumber
@onready var populaity_diffrence_number: Label = %PopulaityDiffrenceNumber
@onready var day_label: Label = %DayLabel
@onready var animations: AnimationPlayer = %Animations

var catalog_entries : Array[CatalogEntry]
var stage : Stage = Stage.START

func _ready() -> void:
	Globals.day_controller = self
	hide()

func start_new_day():
	show()
	stage = Stage.START
	people_helped_number.text = str(Globals.day_end_stats["people_helped"])
	flowers_used_number.text = str(Globals.day_end_stats["flowers_used"])
	money_made_number.text = "$" + str(Globals.day_end_stats["money_made"])
	popularity_change_number.text = str(snapped(Globals.day_end_stats["start_popularity"], 0.1)) + " ➜ " + str(snapped(Globals.day_end_stats["current_popularity"], 0.1))
	populaity_diffrence_number.text = str(snapped(Globals.day_end_stats["current_popularity"] - Globals.day_end_stats["start_popularity"], 0.1))
	day_label.text = "Day " + str(Globals.day)
	
	for entry : CatalogEntry in catalog_entries:
		entry.cart_amount = 0
	
	next_stage()
	

func next_stage():
	match stage:
		Stage.START: 
			animations.play("RESET")
			await get_tree().process_frame
			stage = Stage.STATS
			animations.play("intro")
			
		Stage.STATS: 
			stage = Stage.CATALOG
			animations.play("switch_to_catalog")
			
		Stage.CATALOG: 
			for entry : CatalogEntry in catalog_entries:
				Globals.flower_to_count_map[entry.flower_id] += entry.cart_amount
				
			stage = Stage.END
			animations.play("finish")
			await animations.animation_finished
			Globals.starting_money = Globals.money
			Globals.clients.load_new_client()
			hide()
			

func add_day_count():
	Globals.day += 1
	day_label.text = "Day " + str(Globals.day)

func _process(delta: float) -> void:
	pass


func _on_next_pressed() -> void:
	SFX.play("notebook")
	next_stage()
