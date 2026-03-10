extends TextureButton

@export var flower_res : Resource = null
@export var flower_cost: int = 0
@export var count : Label
@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect2: TextureRect = $TextureRect

func _ready():
	texture_normal = flower_res.side_texture
	texture_rect.texture = flower_res.side_texture
	texture_rect2.texture = flower_res.side_texture
	count.text = "$" + str(flower_res.flower_cost)
	tooltip_text = flower_res.flower_name
	
	if Globals.use_jon_short_version:
		count.hide()

func _process(delta):
	var flower_count = Globals.flower_to_count_map[flower_res.flower_id]
	count.text = str(flower_count)
	disabled = flower_count <= 0
	if flower_count == 0:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE

func _on_pressed():
	Globals.selected_flower = texture_normal
	Globals.selected_flower_res = flower_res

	get_tree().call_group("flower_interface", "reset_flower_rotation")
