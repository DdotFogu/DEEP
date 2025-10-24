@icon("res://Assets/icons/icon_call.png")
extends Node
class_name transition_component

signal transition_start
signal transition_end

func await_transition():
	transition_start.emit()
	await scene_handler.await_transition()
	transition_end.emit()
