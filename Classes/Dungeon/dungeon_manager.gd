extends Node 
class_name dungeon_manager

var floor_level : int = 1:
	set(new_level):
		floor_level = new_level
		signal_bus.floor_level_changed.emit(new_level)

signal current_stage_finished

@export_group("dungeon_settings")
@export var possible_stage: Array[PackedScene]= [
	load("res://Classes/Dungeon/levels/level_01.tscn"),
	load("res://Classes/Dungeon/levels/level_02.tscn"),
	load("res://Classes/Dungeon/levels/level_03.tscn"),
	load("res://Classes/Dungeon/levels/level_04.tscn"),
	load("res://Classes/Dungeon/levels/level_05.tscn"),
]

@export var floor_enemy_counts := {
	0: 3,
	6: 5,
	9: 7,
}

@export var exit_door : Node2D
var pickabled_stages: Array
var current_stage: base_level:
	set(new_stage):
		if current_stage: 
			current_stage.queue_free()
		current_stage = new_stage
		owner.add_child.call_deferred(new_stage)
		
		var enemy_count = get_enemy_count()
		await new_stage.ready; new_stage.spawn_enemies(new_stage.create_enemies(enemy_count))
		exit_door.global_position = current_stage.end_position
		global.player.global_position = current_stage.start_position

func get_enemy_count(count_map:Dictionary=floor_enemy_counts, level:int=floor_level)->int:
	var keys=count_map.keys(); keys.sort()
	var result:int=count_map[keys[0]]
	for key in keys:
		if level >= key:
			result = count_map[key]
		else:
			break
	return result

func _ready() -> void:
	exit_door.get_node('interact_component').interact.connect(func(): 
		current_stage_finished.emit()
	)
	
	signal_bus.floor_level_changed.emit(floor_level)
	reset_pickable()
	set_new_stage()

func add_to_floor_level(amount:int=1):
	floor_level += amount
	return floor_level

func set_new_stage():
	var new_scene: PackedScene = random_level()
	if new_scene==null:return
	current_stage = new_scene.instantiate()
	
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false

func random_level() -> PackedScene:
	if pickabled_stages.is_empty():
		reset_pickable()
	var random_scene = pickabled_stages.pick_random()
	pickabled_stages.erase(random_scene)
	return random_scene

func reset_pickable():
	pickabled_stages = possible_stage.duplicate()
