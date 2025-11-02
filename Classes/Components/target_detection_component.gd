@icon("res://Assets/icons/icon_event.png")
extends Area2D
class_name target_dection_component

@export_group('Component Settings')
@export var los : bool = true
var los_ray : RayCast2D

signal target_enetered
signal target_exited

func _init() -> void:
	body_entered.connect(_on_target_eneter)
	body_exited.connect(_on_target_exit)
	
	los_ray = RayCast2D.new()
	los_ray.scale = Vector2(0.9,0.9)
	los_ray.collision_mask = 2

func _ready() -> void:
	if los: add_child(los_ray)
	else: los_ray.queue_free()

func _on_target_eneter(_body: Node2D):
	if !has_los(_body): return
	(func(): target_enetered.emit()).call_deferred()

func _on_target_exit(_body: Node2D):	
	if !has_los(_body): return
	(func(): target_exited.emit()).call_deferred()

func has_los(_body : Node2D):
	if !los: 
		return true
	
	los_ray.target_position = to_local(_body.global_position)
	los_ray.force_raycast_update()
	return !los_ray.is_colliding()
