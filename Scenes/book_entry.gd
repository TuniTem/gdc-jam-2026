extends ColorRect
class_name Entry

@onready var animation: AnimationPlayer = $Animation

@export var unlock_id : String
@export var page : int

func _ready() -> void:
	Globals.unlocks.append(self)

	if Globals.DEBUG:
		animation.play("paint_in")
