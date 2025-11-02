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
	
	var tween = get_tree().create_tween()
	tween.tween_property(ammo_progress, 'value', current_ammo, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
