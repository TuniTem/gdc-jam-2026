extends Control

@onready var people_helped_number: Label = %PeopleHelpedNumber
@onready var flowers_used_number: Label = %FlowersUsedNumber
@onready var money_made_number: Label = %MoneyMadeNumber
@onready var popularity_change_number: Label = %PopularityChangeNumber
@onready var populaity_diffrence_number: Label = %PopulaityDiffrenceNumber

func start_new_day():
	people_helped_number.text = str(Globals.day_end_stats["people_helped"])
	flowers_used_number.text = str(Globals.day_end_stats["flowers_used"])
	money_made_number.text = str(Globals.day_end_stats["money_made"])
	popularity_change_number.text = str(snapped(Globals.day_end_stats["start_popularity"], 0.1)) + " ➜ " + str(snapped(Globals.day_end_stats["current_popularity"], 0.1))
	populaity_diffrence_number.text = str(snapped(Globals.day_end_stats["current_popularity"] - Globals.day_end_stats["start_popularity"], 0.1))

func _process(delta: float) -> void:
	pass


func _on_next_pressed() -> void:
	pass # Replace with function body.
