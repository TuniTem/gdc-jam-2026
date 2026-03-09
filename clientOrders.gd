# characters.gd
extends Node

func _ready() -> void:
	return

func _populate():
	Globals.characters = _create_characters()
	for c in Globals.characters:
		print("%s: '%s'" % [c.character_name, c.intro_line])


func _create_characters() -> Array[CharacterData]:
	var policeman := CharacterData.new()
	policeman.character_name = "Alan"
	policeman.intro_line = "My grampa died, give me flowers"
	policeman.portrait = load("res://sprites/characters/char-0.png")
	policeman.flowers = {"tulip": 12, "rose": 8, "babybreath": 6, "thorn": 10}
	policeman.budget = 50

	var soccermom := CharacterData.new()
	soccermom.character_name = "Seraphine"
	soccermom.intro_line = "Its my sons birthday"
	soccermom.portrait = load("res://sprites/characters/char-1.png")
	soccermom.flowers = {"tulip": 4, "rose": 7, "babybreath": 18, "thorn": 5}
	soccermom.budget = 100

	var grampa := CharacterData.new()
	grampa.character_name = "Dylan"
	grampa.intro_line = "Its my wife and my 40th aniversty"
	grampa.portrait = load("res://sprites/characters/char-2.png")
	grampa.flowers = {"tulip": 7, "rose": 16, "babybreath": 10, "thorn": 6}
	grampa.budget = 125

	var richguy := CharacterData.new()
	richguy.character_name = "Maximillion"
	richguy.intro_line = "Its a normal friday"
	richguy.portrait = load("res://sprites/characters/char-3.png")
	richguy.flowers = {"tulip": 10, "rose": 6, "lilly": 9, "thorn": 15}
	richguy.budget = 75

	var parkingattendant := CharacterData.new()
	parkingattendant.character_name = "Owen"
	parkingattendant.intro_line = "My life sucks"
	parkingattendant.portrait = load("res://sprites/characters/char-4.png")
	parkingattendant.flowers = {"tulip": 9, "rose": 13, "lilly": 11, "thorn": 8}
	parkingattendant.budget = 200

	return [policeman, soccermom, grampa, richguy, parkingattendant]
