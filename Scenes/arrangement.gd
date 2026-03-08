extends Node2D


const STEM_PULL_AMOUNT = 50.0
const START_STEM_PULL_RADIUS = 40.0
const STEM_LINE_WIDTH = 5.0

const PUSH_AMMOUNT = 300.0
const CENTER_PULL = 1.0
const DRAG = 50000.0
const FLOWER_SCENE = preload("res://Scenes/flower.tscn")

var placing_flower : Flower
var flowers : Array[Flower]
var velocity : Dictionary[Flower, Vector2]

@export var use_placeholder_flower = false

#func _ready() -> void:
	#for key : Flower in flowers:
		#velocity[key] = Vector2.ZERO

func _process(delta: float) -> void:
	queue_redraw()
	sim_flowers(delta)
	if placing_flower != null:
		placing_flower.position = get_local_mouse_position()
		placing_flower.stem_pos = placing_flower.position
		

func is_hovering_over_flower_button():
	for fw_btn in get_tree().get_nodes_in_group("flower_button"):
		var mouse_rect = Rect2(get_global_mouse_position(), Vector2.ZERO)
		if fw_btn.get_global_rect().encloses(mouse_rect):
			return true
	return false

func _input(event: InputEvent) -> void:
	var can_place_flower = use_placeholder_flower or (Globals.selected_flower != null and !is_hovering_over_flower_button())
	if event.is_action_pressed("pick_flower") and can_place_flower:
		var inst : Flower = FLOWER_SCENE.instantiate()
		inst.position = get_local_mouse_position()
		placing_flower = inst
		placing_flower.modulate.a = 0.5
		velocity[inst] = Vector2.ZERO
		flowers.append(inst)
		add_child(inst)
		if not use_placeholder_flower:
			inst.set_texture(Globals.selected_flower_res.flower_texture)
	
	if event.is_action_released("pick_flower") and can_place_flower:
		placing_flower.modulate.a = 1.0
		placing_flower = null
		if not use_placeholder_flower:
			get_tree().get_first_node_in_group("side_bouquet").add_flower(Globals.selected_flower_res)

func sim_flowers(delta):
	for flower : Flower in flowers:
		var accel : Vector2 = Vector2.ZERO
		
		for flower_affector : Flower in flowers:
			var direction : Vector2 = (flower.position - flower_affector.position)
			if direction.length() > flower_affector.radius: continue
			
			accel += direction * PUSH_AMMOUNT
			
		var center_dir : Vector2 = -flower.position
		var stem_dir : Vector2 = flower.position - flower.stem_pos
		
		accel += center_dir * CENTER_PULL
		
		if stem_dir.length() > START_STEM_PULL_RADIUS:
			accel += -stem_dir * STEM_PULL_AMOUNT
		
		velocity[flower] += accel * delta
		velocity[flower] = lerp(velocity[flower], Vector2.ZERO, DRAG * delta * 0.001)
		flower.move(velocity[flower] * delta, delta)

func _draw() -> void:
	for flower : Flower in flowers:
		draw_circle(flower.stem_pos, STEM_LINE_WIDTH/2.0, Color(0.245, 0.51, 0.245, 1.0))
		draw_line(flower.position, flower.stem_pos, Color(0.245, 0.51, 0.245, 1.0), STEM_LINE_WIDTH, true)
