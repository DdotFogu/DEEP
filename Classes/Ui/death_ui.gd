extends Control

signal death_emitted
signal restart

@onready var retry: TextureButton = $buttons/vbox/retry
@onready var menu: TextureButton = $buttons/vbox/menu
@onready var quit: TextureButton = $buttons/vbox/quit
@onready var arrow: AnimatedSprite2D = $buttons/arrow
@onready var title: Label = $info/title

func _process(delta: float) -> void:
	if get_viewport().gui_get_focus_owner():
		arrow.position = get_viewport().gui_get_focus_owner().global_position + Vector2(
		get_viewport().gui_get_focus_owner().size.x + 5, get_viewport().gui_get_focus_owner().size.y / 1.9)

func _ready() -> void:
	retry.pressed.connect(restart_game)
	menu.pressed.connect(func():
		global.transition_ui.transition_scene(load("res://main_menu.tscn"))
		signal_bus.player_dead = false
		)
	quit.pressed.connect(func(): get_tree().quit())
	signal_bus.player_died.connect(func(): 
		audio.toggle_sound('dungeon_music', false)
		death_emitted.emit())

func restart_game() -> void:
		signal_bus.player_dead = false
		await global.transition_ui.transition_scene(load("res://Classes/Dungeon/dungeon_scene.tscn"))
		restart.emit()
		signal_bus.player_health_changed.emit(4)
		signal_bus.player_ammo_changed.emit(4)

func update_info():
	title.text = """you died
		levels cleared : {l}
		time taken : {t}""".format({
		"l": global.levels_cleared,
		"t": "%.1f" % global.current_time
	})
