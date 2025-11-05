extends CharacterBody2D
class_name base_character

@export var stats : StatSheet
@onready var animation : AnimatedSprite2D = get_node("sprite")

var state_machine : state_machine
func _ready() -> void:
	if has_node('state_machine'): state_machine = get_node('state_machine')

func face_direction():
	if !animation: return
	
	var direction := Vector2.ZERO
	if animation.flip_h == false: direction = Vector2(1, 0)
	else: direction = Vector2(-1, 0)
	return direction

func add_velocity(added_velocity:Vector2):
	velocity += added_velocity
	return velocity
