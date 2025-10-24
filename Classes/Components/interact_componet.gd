@icon("res://Assets/icons/icon_event.png")
extends Area2D
class_name interact_component

@export var enabled : bool = true

var cursor : AnimatedSprite2D

signal interact
signal body_enter
signal body_exit

func _ready() -> void:
	if!has_node('arrow'):return
	cursor = get_node('arrow')

func _input(event: InputEvent) -> void:
	if !enabled: return
	
	if event.is_action_pressed('interact'):
		if get_overlapping_bodies().has(global.player):
			interact.emit()

func body_entered(_body: Node2D):
	toggle_cursor(true)
	body_enter.emit()

func body_exited(_body: Node2D):
	toggle_cursor(false)
	body_exit.emit()

func toggle_cursor(enable := false):
	if !cursor: return
	cursor.visible = enable
