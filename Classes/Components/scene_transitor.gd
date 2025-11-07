@icon("res://Assets/icons/icon_file.png")
extends base_component
class_name scene_transitor

@export var scene : PackedScene

func trans_change_scene(): 
	global.transition_ui.transition_scene(scene)

func change_scene(): global.transition_ui.change_scene(scene)
