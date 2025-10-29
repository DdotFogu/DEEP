@icon("res://Assets/icons/icon_sword.png")
extends Area2D
class_name hitbox_component

signal enemy_hit

@export_group('Component Settings')
@export var attack : Attack
@export var killer : Node
@export var target_groups : Array[String] = ['Player']

func _init() -> void:
	collision_layer = 8
	collision_mask = 0
