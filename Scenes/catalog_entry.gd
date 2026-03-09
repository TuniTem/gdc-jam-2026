extends Control
class_name CatalogEntry

@export var controller : Control
@export var flower : String
@export var price : int
@export var type : String


@onready var description: RichTextLabel = %Description
@onready var inventory: Label = %Inventory
@onready var cart: Label = %Cart
@onready var title: Label = %Title

var cart_amount : int = 0:
	set(val):
		cart.text = str(val)
		cart_amount = val

func _ready() -> void:
	controller.catalog_entries.append(self)
	title.text = flower
	cart.text = "0"
	description.text = "Type: " + type + " \nPrice: $" + str(price)
	inventory.text = "?" # TODO set inventroy ammount
	

func _on_add_pressed() -> void:
	if Globals.money >= price:
		cart_amount += 1
		Globals.money -= price
