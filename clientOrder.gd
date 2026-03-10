class_name CharacterData
extends Resource

@export var character_name: String = ""
@export var lines: Array[String] = []
@export var portrait: Texture2D = null
@export var flowers: Dictionary[String, int] = {}
@export var budget: int = 0
@export var bouquet: Enums.BouquetType = Enums.BouquetType.NONE
