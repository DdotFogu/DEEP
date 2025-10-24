extends Node
class_name dungeon_manager

signal current_stage_finished

@export_group("dungeon_settings")
@export var possible_stage: Array = [
	load("res://Classes/Dungeon/levels/level_01.tscn"),
	#load("res://Classes/Dungeon/levels/level_02.tscn"),
]

var pickabled_stages: Array
var current_stage: base_level:
	set(new_stage):
		if current_stage: 
			current_stage.queue_free()
		current_stage = new_stage
		current_stage.get_node('exit_door/interact_component').interact.connect(
			func(): current_stage_finished.emit()
			)
		owner.add_child.call_deferred(new_stage)
		
		global.player.global_position = current_stage.spawn_pos.global_position

func _ready() -> void:
	reset_pickable()
	set_new_stage()

func set_new_stage():
	if pickabled_stages.is_empty():
		reset_pickable()
	var new_scene: PackedScene = random_level()
	current_stage = new_scene.instantiate()

func random_level() -> PackedScene:
	if pickabled_stages.is_empty():
		reset_pickable()
	var random_scene = pickabled_stages.pick_random()
	pickabled_stages.erase(random_scene)
	return random_scene

func reset_pickable():
	pickabled_stages = possible_stage.duplicate()
