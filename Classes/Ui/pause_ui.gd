extends Control

@onready var retry: TextureButton = $MarginContainer/vbox/retry
@onready var quit: TextureButton = $MarginContainer/vbox/quit
@onready var menu: TextureButton = $MarginContainer/vbox/menu

signal paused
signal unpaused

@export var can_pause : bool = true

func _ready() -> void:
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
			menu.grab_focus()
			paused.emit()
		else: unpaused.emit()
