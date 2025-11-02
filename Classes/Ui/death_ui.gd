extends Control

var able_to_retry : bool = false

signal death_emitted
signal restart

func _ready() -> void:
	signal_bus.player_died.connect(func(): death_emitted.emit(); able_to_retry = true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and able_to_retry:
		able_to_retry = false
		signal_bus.player_dead = false
		await global.transition_ui.transition_scene(load("res://home.tscn"))
		restart.emit()
		signal_bus.player_health_changed.emit(4)
		signal_bus.player_ammo_changed.emit(4)
