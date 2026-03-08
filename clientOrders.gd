# characters.gd
extends Node

func _ready() -> void:
	Globals.characters = _create_characters()
	for c in Globals.characters:
		print("%s: '%s'" % [c.character_name, c.intro_line])


func _create_characters() -> Array[CharacterData]:
	var policeman := CharacterData.new()
	policeman.character_name = "Alan"
	policeman.intro_line = "My grampa died, give me flowers"
	policeman.portrait = null
	policeman.flowers = {"tulip": 12, "rose": 8, "babybreath": 6, "thorn": 10}

	var soccermom := CharacterData.new()
	soccermom.character_name = "Seraphine"
	soccermom.intro_line = "Its my sons birthday"
	soccermom.portrait = null
	soccermom.flowers = {"tulip": 4, "rose": 7, "babybreath": 18, "thorn": 5}

	var grampa := CharacterData.new()
	grampa.character_name = "Dylan"
	grampa.intro_line = "Its my wife and my 40th aniversty"
	grampa.portrait = null
	grampa.flowers = {"tulip": 7, "rose": 16, "babybreath": 10, "thorn": 6}

	var richguy := CharacterData.new()
	richguy.character_name = "Maximillion"
	richguy.intro_line = "Its a normal friday"
	richguy.portrait = null
	richguy.flowers = {"tulip": 10, "rose": 6, "lilly": 9, "thorn": 15}

	var parkingattendant := CharacterData.new()
	parkingattendant.character_name = "Owen"
	parkingattendant.intro_line = "My life sucks"
	parkingattendant.portrait = null
	parkingattendant.flowers = {"tulip": 9, "rose": 13, "lilly": 11, "thorn": 8}

	return [policeman, soccermom, grampa, richguy, parkingattendant]
