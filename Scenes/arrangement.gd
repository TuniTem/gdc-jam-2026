extends Node2D

const PUSH_AMMOUNT = 200.0
const CENTER_PULL = 4.0
const DRAG = 40000.0
const FLOWER_SCENE = preload("uid://b3ikl4lshquqx")

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
		accel += center_dir  * CENTER_PULL
		#print(accel)
		velocity[flower] += accel * delta
		velocity[flower] = lerp(velocity[flower], Vector2.ZERO, DRAG * delta * 0.001)
		flower.move(velocity[flower] * delta, delta)
