extends Control

@onready var fps_label: Label = $fps_label

func _process(_delta: float) -> void:
	fps_label.text = 'fps: ' + str(Engine.get_frames_per_second())
