extends CharacterBody2D
class_name base_character

@export var stats : StatSheet
@onready var animation : AnimatedSprite2D = get_node("sprite")

func _ready() -> void:
	if !debugger.character_array.has(self): debugger.character_array.append(self)

func face_direction():
	if !animation: return
	
	var direction := Vector2.ZERO
	if animation.flip_h == false: direction = Vector2(1, 0)
	else: direction = Vector2(-1, 0)
	return direction
