extends Control

@onready var play: TextureButton = $MarginContainer/vbox/play
@onready var settings: TextureButton = $MarginContainer/vbox/settings
@onready var quit: TextureButton = $MarginContainer/vbox/quit
@onready var settings_menu: Control = $"../settings"
@onready var menu: TextureButton = $"../settings/MarginContainer/vbox/menu"

func _ready() -> void:
	quit.pressed.connect(func(): get_tree().quit())
	settings.pressed.connect(func():
		hide()
		settings_menu.show()
		menu.grab_focus()
		)
	play.grab_focus()
