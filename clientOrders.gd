# characters.gd
extends Node

func _ready() -> void:
	return

func _populate():
	Globals.characters = _create_characters()

func _create_characters() -> Array[CharacterData]:
	var policeman := CharacterData.new()
	policeman.character_name = "Alan"
	policeman.lines = [
		"Hey, I'd love a Barthemelo Bouquet..!",
		"It's for my fiance.",
		"Please abc 123"
	]
	policeman.portrait = load("res://sprites/characters/char-0.png")
	policeman.flowers = {"tulip": 12, "rose": 8, "babybreath": 6, "thorn": 10}
	policeman.bouquet = Enums.BouquetType.Barthemelo
	policeman.budget = 50

	var soccermom := CharacterData.new()
	soccermom.character_name = "Seraphine"
	soccermom.lines = ["Its my sons birthday", "I'd love a Lazy Eye bouquet for him."]
	soccermom.portrait = load("res://sprites/characters/char-1.png")
	soccermom.flowers = {"tulip": 4, "rose": 7, "babybreath": 18, "thorn": 5}
	soccermom.bouquet = Enums.BouquetType.LazyEye
	soccermom.budget = 100

	var grampa := CharacterData.new()
	grampa.character_name = "Dylan"
	grampa.lines = ["Its my wife and my 40th aniversty", "They love expeditions.", "Is there a bouquet for that?"]
	grampa.portrait = load("res://sprites/characters/char-2.png")
	grampa.flowers = {"tulip": 7, "rose": 16, "babybreath": 10, "thorn": 6}
	grampa.bouquet = Enums.BouquetType.Expedition
	grampa.budget = 125

	var richguy := CharacterData.new()
	richguy.character_name = "Maximillion"
	richguy.lines = ["Its a normal friday", "One might say it's the sixth day of the week", "Can you use that for a bouquet?"]
	richguy.portrait = load("res://sprites/characters/char-3.png")
	richguy.flowers = {"tulip": 10, "rose": 6, "lilly": 9, "thorn": 15}
	richguy.bouquet = Enums.BouquetType.SixPin
	richguy.budget = 75

	var parkingattendant := CharacterData.new()
	parkingattendant.character_name = "Owen"
	parkingattendant.lines = ["My life sucks", "I do love insects tho."]
	parkingattendant.portrait = load("res://sprites/characters/char-4.png")
	parkingattendant.flowers = {"tulip": 9, "rose": 13, "lilly": 11, "thorn": 8}
	parkingattendant.bouquet = Enums.BouquetType.Grasshopper
	parkingattendant.budget = 200
	
	var anotherperson := CharacterData.new()
	anotherperson.character_name = "Margaret"
	anotherperson.lines = ["One pence", "Two pence", "Three pence", "Four Pence!"]
	anotherperson.portrait = load("res://sprites/characters/char-5.png")
	anotherperson.flowers = {"tulip": 9, "rose": 13, "lilly": 11, "thorn": 8}
	anotherperson.bouquet = Enums.BouquetType.FourPence
	anotherperson.budget = 150

	return [policeman, soccermom, grampa, richguy, parkingattendant, anotherperson]
