@icon("res://Assets/icons/icon_file.png")
extends base_component
class_name scene_transitor

@export var scene : PackedScene

func trans_change_scene(): scene_handler.transition_scene(scene)

func change_scene(): scene_handler.change_scene(scene)
