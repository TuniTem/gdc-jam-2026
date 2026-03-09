extends Node2D

@onready var moneyLabel: Label = %MoneyLabel
@onready var boquetLabel: Label = %BouquetCostLabel
var bouquet: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	moneyLabel.text = str("Money: $", Globals.money)
	bouquet = Globals.get_current_arrangement_flower_resources()
	var total = 0
	if len(bouquet) > 0:
		for flower in bouquet:
			#print(flower.flower_cost)
			total += flower.flower_cost
	Globals.bouquet_cost = total
	boquetLabel.text = str("-$", Globals.bouquet_cost)
