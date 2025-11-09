extends Control

@onready var retry: TextureButton = $MarginContainer/vbox/retry
@onready var quit: TextureButton = $MarginContainer/vbox/quit
@onready var menu: TextureButton = $MarginContainer/vbox/menu

signal paused
signal unpaused

@export var can_pause : bool = true

var last_focus_owner: Control = null
signal focus_changed

func _process(_delta: float) -> void:
	var focus_owner = get_viewport().gui_get_focus_owner()
	if focus_owner != last_focus_owner and focus_owner != null:
		last_focus_owner = focus_owner
		focus_changed.emit()

func _ready() -> void:
	visible = false
	menu.pressed.connect(func(): global.transition_ui.transition_scene(load("res://main_menu.tscn")))
	quit.pressed.connect(func(): get_tree().quit())
	retry.pressed.connect(func(): get_tree().reload_current_scene())

func _init() -> void:
	signal_bus.enter_transition.connect(func(): can_pause = false)
	signal_bus.exit_transition.connect(func(): can_pause = true)

func _input(event: InputEvent) -> void:
	if !can_pause: return
	
	if event.is_action_pressed('toggle_pause'):
		var is_paused = !get_tree().paused
		get_tree().paused = is_paused
		
		if is_paused: 
			audio.toggle_sound('dungeon_music', false)
			menu.grab_focus()
			paused.emit()
		else: 
			audio.toggle_sound('dungeon_music', true)
			unpaused.emit()
