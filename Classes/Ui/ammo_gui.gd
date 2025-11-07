extends Control

@onready var ammo_progress: TextureProgressBar = $ammo_progress

func _init() -> void:
	signal_bus.player_ammo_changed.connect(update_progress)
	signal_bus.player_max_ammo_changed.connect(update_max)

func update_max(max_amount:int):
	if !ammo_progress: return
	ammo_progress.max_value = max_amount

func update_progress(current_ammo:int):
	if !ammo_progress: return
	if !get_tree(): return
	
	ammo_progress.value = current_ammo
