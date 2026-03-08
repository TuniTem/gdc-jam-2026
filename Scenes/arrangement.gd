extends Node2D

const STEM_PULL_AMOUNT = 50.0
const START_STEM_PULL_RADIUS = 40.0
const STEM_LINE_WIDTH = 5.0

const PUSH_AMMOUNT = 300.0
const CENTER_PULL = 1.0
const DRAG = 50000.0
const FLOWER_SCENE = preload("uid://b3ikl4lshquqx")

var placing_flower : Flower
var flowers : Array[Flower]
var velocity : Dictionary[Flower, Vector2]


#func _ready() -> void:
	#for key : Flower in flowers:
		#velocity[key] = Vector2.ZERO

func _process(delta: float) -> void:
	queue_redraw()
	sim_flowers(delta)
	if placing_flower != null:
		placing_flower.position = get_local_mouse_position()
		placing_flower.stem_pos = placing_flower.position
		
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pick_flower"):
		var inst : Flower = FLOWER_SCENE.instantiate()
		inst.position = get_local_mouse_position()
		placing_flower = inst
		placing_flower.modulate.a = 0.5
		velocity[inst] = Vector2.ZERO
		flowers.append(inst)
		add_child(inst)
	
	if event.is_action_released("pick_flower"):
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
