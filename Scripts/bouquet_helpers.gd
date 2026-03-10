extends Node

func get_bouquet_name(bouquet_type):
	match bouquet_type:
		Enums.BouquetType.NONE:
			return "none"
		Enums.BouquetType.Barthemelo:
			return "barthemelo"
		Enums.BouquetType.LazyEye:
			return "lazy_eye"
		Enums.BouquetType.Expedition:
			return "expedition"
		Enums.BouquetType.SixPin:
			return "six_pin"
		Enums.BouquetType.Grasshopper:
			return "grasshopper"
		Enums.BouquetType.FourPence:
			return "four_pence"
	return "None"

func has_flower(flower : String, flowers) -> bool:
	for flower_test in flowers:
		if flower_test.flower_id == flower:
			return true
	
	return false

func get_bouquet_type(flowers):
	var focal_count = 0
	var filler_count = 0
	var foliage_count = 0
	for flower in flowers:
		if flower.flower_type == Enums.FlowerType.FOCAL:
			focal_count += 1
		elif flower.flower_type == Enums.FlowerType.FOLIAGE:
			foliage_count += 1
		elif flower.flower_type == Enums.FlowerType.FILLER:
			filler_count += 1
	
	if focal_count == 3 and filler_count == 2 and foliage_count == 6:
		return Enums.BouquetType.Barthemelo
	elif focal_count == 2 and filler_count == 4 and foliage_count == 6:
		return Enums.BouquetType.LazyEye
	elif focal_count == 1 and filler_count == 3 and foliage_count == 3:
		return Enums.BouquetType.Expedition
	elif focal_count == 6 and filler_count == 2 and foliage_count == 0:
		return Enums.BouquetType.SixPin
	elif focal_count == 0 and filler_count == 1 and foliage_count == 7:
		return Enums.BouquetType.Grasshopper
	elif focal_count == 4 and filler_count == 0 and foliage_count == 6:
		return Enums.BouquetType.FourPence
	else:
		return Enums.BouquetType.NONE
