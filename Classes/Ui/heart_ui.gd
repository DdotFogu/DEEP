extends Control

@export var hp_progress : TextureProgressBar
@onready var counter: Label = $counter

func _init() -> void:
	signal_bus.player_health_changed.connect(update_progress)
	signal_bus.player_max_health_changed.connect(update_max)

func update_max(max_amount:int):
	if !hp_progress: return
	hp_progress.max_value = max_amount
	if !counter: return
	counter.text = "{value}/{max}".format({'value': int(hp_progress.value), 'max': int(hp_progress.max_value)})

func update_progress(current_ammo:int):
	if !hp_progress: return
	hp_progress.value = current_ammo
	if !counter: return
	counter.text = "{value}/{max}".format({'value': int(hp_progress.value), 'max': int(hp_progress.max_value)})
