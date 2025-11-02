extends Node
class_name teleport_component

@export_group("Component Settings")
@export var default_teleport_pos : Vector2
@export var target_body : Node2D
@export var stop_velocity : bool = true

func teleport(body:Node2D=null, teleport_pos:=default_teleport_pos):
	var body_to_teleport = target_body if target_body != null else body
	if !body_to_teleport: return
	
	if stop_velocity && body_to_teleport is CharacterBody2D:
		body_to_teleport.velocity = Vector2.ZERO
	body_to_teleport.global_position = teleport_pos
