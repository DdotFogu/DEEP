extends Control

signal death_emitted
signal restart

@onready var retry: TextureButton = $buttons/vbox/retry
@onready var menu: TextureButton = $buttons/vbox/menu
@onready var quit: TextureButton = $buttons/vbox/quit
@onready var info_label: Label = $info/MarginContainer/VBoxContainer/info_label

@onready var arrow: AnimatedSprite2D = $buttons/arrow

var last_focus_owner: Control = null
signal focus_changed

func _process(_delta: float) -> void:
	var focus_owner = get_viewport().gui_get_focus_owner()
	if focus_owner != last_focus_owner and focus_owner != null and arrow:
		last_focus_owner = focus_owner
		focus_changed.emit()
		arrow.position = focus_owner.global_position + Vector2(
			focus_owner.size.x + 5,
			focus_owner.size.y / 1.9
		)

func _ready() -> void:
	retry.pressed.connect(restart_game)
	menu.pressed.connect(func():
		audio.toggle_sound('death_music', false)
		global.transition_ui.transition_scene(load("res://main_menu.tscn"))
		signal_bus.player_dead = false
		)
	quit.pressed.connect(func(): get_tree().quit())
	signal_bus.player_died.connect(func(): 
		audio.play_sound('death_music', Vector2.ONE)
		audio.toggle_sound('dungeon_music', false)
		death_emitted.emit())

func restart_game() -> void:
		audio.toggle_sound('death_music', false)
		signal_bus.player_dead = false
		await global.transition_ui.transition_scene(load("res://Classes/Dungeon/dungeon_scene.tscn"))
		restart.emit()
		signal_bus.player_health_changed.emit(4)
		signal_bus.player_ammo_changed.emit(4)

func update_info():
	info_label.text = """
		levels cleared: {l}
		time taken: {t}""".format({
		"l": global.levels_cleared,
		"t": "%.1f" % global.current_time
	})
