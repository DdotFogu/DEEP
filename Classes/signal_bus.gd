extends Node

var player_dead : bool = false

func _ready() -> void:
	player_died.connect(func(): player_dead = true)

signal player_died

signal player_health_changed(current_health : int)
signal player_max_health_changed(max_health : int)

signal player_ammo_changed(current_ammo : int)
signal player_max_ammo_changed(max_ammo : int)

signal floor_level_changed(level:int)

signal enter_transition
signal exit_transition

signal shake_cam(intensity:float, time:float)
