@icon("res://Assets/icons/icon_sword.png")
extends Area2D
class_name hitbox_component

signal enemy_hit

@export_category("Hitbox")
@export var killer : CharacterBody2D # Who did the damage in the event
@export var damage : int
@export var knockback_direction := Vector2.ZERO
@export var stun_time : float
@export var target_group : String = "Enemy"

func _init() -> void:
	collision_layer = 8
	collision_mask = 0

func set_rotation_to_velocity():
	rotation = killer.velocity.angle()
	return rotation

func set_rotation_to_mouse():
	rotation = global_position.direction_to(get_global_mouse_position()).angle()
