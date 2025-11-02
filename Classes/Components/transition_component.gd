@icon("res://Assets/icons/icon_call.png")
extends Node
class_name transition_component

signal transition_start
signal transition_end

func _init() -> void:
	transition_start.connect(func(): get_tree().paused = true)
	transition_end.connect(func(): get_tree().paused = false)

func await_transition():
	transition_start.emit()
	await global.transition_ui.await_transition()
	transition_end.emit()
