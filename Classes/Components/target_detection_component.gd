@icon("res://Assets/icons/icon_event.png")
extends Area2D
class_name target_detection_component

@export_group("Component Settings")
@export var los: bool = true
@export var los_check_interval: float = 1.0

var los_ray: RayCast2D
var los_timer: Timer
var bodies_in_area: Array = []

signal target_entered
signal target_exited

func _init() -> void:
	body_entered.connect(_on_target_enter)
	body_exited.connect(_on_target_exit)

	los_ray = RayCast2D.new()
	los_ray.scale = Vector2(0.9, 0.9)
	los_ray.collision_mask = 2

	los_timer = Timer.new()
	los_timer.wait_time = los_check_interval
	los_timer.timeout.connect(_check_los_for_all)
	add_child(los_timer)

func _ready() -> void:
	if los:
		add_child(los_ray)
		los_timer.start()
	else:
		if los_ray.get_parent():
			los_ray.queue_free()
		los_timer.stop()

func _on_target_enter(body: Node2D) -> void:
	if body not in bodies_in_area:
		bodies_in_area.append(body)
		if !los:
			(func(): target_entered.emit()).call_deferred()
			return

func _on_target_exit(body: Node2D) -> void:
	if body in bodies_in_area:
		bodies_in_area.erase(body)
		(func(): target_exited.emit()).call_deferred()

func _check_los_for_all() -> void:
	if !los:
		return
	for body in bodies_in_area.duplicate():
		if !is_instance_valid(body):
			bodies_in_area.erase(body)
			continue
		if has_los(body):
			(func(): target_entered.emit()).call_deferred()
			bodies_in_area.erase(body)

func has_los(body: Node2D) -> bool:
	if !los:
		return true
	los_ray.target_position = to_local(body.global_position)
	los_ray.force_raycast_update()
	return !los_ray.is_colliding()
