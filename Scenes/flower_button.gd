extends TextureButton

@export var flower_res : Resource = null
@export var flower_cost: int = 0

func _ready():
	texture_normal = flower_res.side_texture
	
func _on_pressed():
	Globals.selected_flower = texture_normal
	Globals.selected_flower_res = flower_res

	get_tree().call_group("flower_interface", "reset_flower_rotation")
