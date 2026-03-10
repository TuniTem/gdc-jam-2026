extends Node2D

@onready var moneyLabel: Label = %MoneyLabel
@onready var boquetLabel: Label = %BouquetCostLabel
@onready var totalValueLabel: Label = %TotalValueLabel

@export var starting_money: int = 100

var bouquet: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# start game with money
	print(Globals.starting_money)
	Globals.starting_money = starting_money
	Globals.money = Globals.starting_money
	print("starting money: ", Globals.starting_money)
	if Globals.use_jon_short_version:
		$%MoneyLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	moneyLabel.text = str("Money: $", Globals.money)
	bouquet = Globals.get_current_arrangement_flower_resources()
	_set_bouquet_cost()
	_set_total_value()
	if Globals.current_character < 6:
		$CanvasLayer/BudgetAmt.text = "$" + str(Globals.characters[Globals.current_character].budget)
	
func _set_bouquet_cost() -> void:
	var total = 0
	if len(bouquet) > 0:
		for flower in bouquet:
			#print(flower.flower_cost)
			total += flower.flower_cost
	Globals.bouquet_cost = total
	boquetLabel.text = str("-$", Globals.bouquet_cost)
	
func _set_total_value() -> void:
	var total = 0
	if len(bouquet) > 0:
		for flower in bouquet:
			total += flower.flower_worth
	Globals.total_value = total
	totalValueLabel.text = str("Bouquet Value: $", Globals.total_value)
