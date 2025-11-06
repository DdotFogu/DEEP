extends Control

@onready var ammo_progress: TextureProgressBar = $ammo_progress
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _init() -> void:
	signal_bus.player_ammo_changed.connect(update_progress)
	signal_bus.player_max_ammo_changed.connect(update_max)
	signal_bus.floor_level_changed.connect(func(level:int):
		if level % 3 == 0:
			animation_player.play('replenish')
		)

func update_max(max_amount:int):
	if !ammo_progress: return
	ammo_progress.max_value = max_amount

func update_progress(current_ammo:int):
	if !ammo_progress: return
	if !get_tree(): return
	
	ammo_progress.value = current_ammo
