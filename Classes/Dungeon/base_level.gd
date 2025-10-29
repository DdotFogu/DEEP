@icon("res://Assets/icons/icon_door.png")
extends Node2D
class_name base_level 

@export var possible_enemies := {
	'frog': preload("res://Classes/Enemies/Frog/frog.tscn"),
	'crawler': preload("res://Classes/Enemies/Crawler/crawler.tscn"),
	
}
@export var start_position : Vector2
@export var end_position : Vector2
@export var enemy_layer : TileMapLayer

var spawn_groups:={}

func _ready() -> void: 
	for coords in enemy_layer.get_used_cells():
		var tile_data = enemy_layer.get_cell_tile_data(coords).get_custom_data("SpawnType")
		if tile_data == null: continue
		if not spawn_groups.has(tile_data):
			spawn_groups[tile_data]=[]
		spawn_groups[tile_data].append(coords)

func spawn_enemies(enemies:Array[base_enemy])->void:
	for enemy in enemies: add_child(enemy)

func create_enemies(amount:int, enemies:Dictionary=possible_enemies)->Array[base_enemy]:
	var enemy_set:Array[base_enemy]
	
	var selection = enemies.values()
	if selection.is_empty():
		printerr("No enemy types defined in 'selection'.")
		return enemy_set
	
	for i in range(amount):
		var new_enemy : base_enemy
		while true:
			if selection.is_empty():
				printerr("Ran out of enemies for instantiating current room")
				return enemy_set
			
			var enemy_scene = selection.pick_random()
			new_enemy = enemy_scene.instantiate()
			
			if new_enemy.enemy_type in spawn_groups:
				break
			else:
				selection.erase(enemy_scene)
				new_enemy.queue_free()
		
		var possible_spawns = spawn_groups.get(new_enemy.enemy_type, [])
		
		if !len(possible_spawns): 
			printerr("Room does not have enough tiles to support {amount} enemies of type: {type}. {i} created.".format({"i": i, "amount": amount, "type": new_enemy.enemy_type}))
			spawn_groups.erase(new_enemy.enemy_type)
			continue
		var random_spawn = possible_spawns.pick_random(); possible_spawns.erase(random_spawn)
		var enemy_spawn = enemy_layer.map_to_local(random_spawn)
		
		new_enemy.global_position = enemy_spawn
		enemy_set.append(new_enemy)
	
	return enemy_set
