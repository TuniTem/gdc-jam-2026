extends Node2D

const PUSH_AMMOUNT = 200.0
const CENTER_PULL = 4.0
const DRAG = 40000.0
const FLOWER_SCENE = preload("res://Scenes/flower.tscn")

var placing_flower : Flower
var flowers : Array[Flower]
var velocity : Dictionary[Flower, Vector2]


#func _ready() -> void:
	#for key : Flower in flowers:
		#velocity[key] = Vector2.ZERO

func _process(delta: float) -> void:
	sim_flowers(delta)
	if placing_flower != null:
		placing_flower.position = get_local_mouse_position()
		

func is_hovering_over_flower_button():
	for fw_btn in get_tree().get_nodes_in_group("flower_button"):
		var mouse_rect = Rect2(get_global_mouse_position(), Vector2.ZERO)
		if fw_btn.get_global_rect().encloses(mouse_rect):
			return true
	return false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pick_flower") and Globals.selected_flower != null and !is_hovering_over_flower_button():
		var inst : Flower = FLOWER_SCENE.instantiate()
		inst.position = get_local_mouse_position()
		placing_flower = inst
		placing_flower.modulate.a = 0.5
		velocity[inst] = Vector2.ZERO
		flowers.append(inst)
		add_child(inst)
		inst.set_texture(Globals.selected_flower_res.flower_texture)
	
	if event.is_action_released("pick_flower") and Globals.selected_flower != null and !is_hovering_over_flower_button():
		placing_flower.modulate.a = 1.0
		placing_flower = null
		

func sim_flowers(delta):
	for flower : Flower in flowers:
		var accel : Vector2 = Vector2.ZERO
		
		for flower_affector : Flower in flowers:
			var direction : Vector2 = (flower.position - flower_affector.position)
			if direction.length() > flower_affector.radius: continue
			
			accel += direction * PUSH_AMMOUNT
		var center_dir : Vector2 = -flower.position
		accel += center_dir  * CENTER_PULL
		#print(accel)
		velocity[flower] += accel * delta
		velocity[flower] = lerp(velocity[flower], Vector2.ZERO, DRAG * delta * 0.001)
		flower.move(velocity[flower] * delta, delta)
