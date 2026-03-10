extends Control
class_name CatalogEntry

@export var controller : Control
@export var flower : String
@export var flower_id : String
@export var price : int
@export var type : String
@export var resource : Resource


@onready var description: RichTextLabel = %Description
@onready var inventory: Label = %Inventory
@onready var cart: Label = %Cart
@onready var title: Label = %Title
@onready var add_to_cart: ImageButton = $ImageButton

var cart_amount : int = 0:
	set(val):
		cart.text = str(val)
		cart_amount = val

func _ready() -> void:
	price = resource.flower_cost
	controller.catalog_entries.append(self)
	title.text = flower
	cart.text = "0"
	description.text = "Type: " + type + " \nPrice: $" + str(price)

func _process(delta: float) -> void:
	inventory.text = str(Globals.flower_to_count_map[flower_id])
	

	

func _on_add_pressed() -> void:
	if Globals.money >= price:
		cart_amount += 1
		Globals.money -= price
		add_to_cart.modulate = Color(0.0, 1.0, 0.0, 1.0)
	
	else:
		add_to_cart.modulate = Color(1.0, 0.0, 0.0, 1.0)
	
	Util.tween(add_to_cart, "modulate", Color.WHITE, 0.2)
	
