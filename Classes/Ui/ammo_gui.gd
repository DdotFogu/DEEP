extends Control

func _init() -> void:
	signal_bus.player_ammo_changed.connect(update_progress)
	signal_bus.player_max_ammo_changed.connect(update_max)

func update_max(max_amount:int):
	var progress : TextureProgressBar = get_node('ammo_progress')
	progress.max_value = max_amount

func update_progress(current_ammo:int):
	var progress : TextureProgressBar = get_node('ammo_progress')
	progress.value = current_ammo
