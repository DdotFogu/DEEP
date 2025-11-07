extends Control

@onready var menu: TextureButton = $MarginContainer/vbox/menu
@onready var main: Control = $"../main"
@onready var settings: TextureButton = $"../main/MarginContainer/vbox/settings"
@onready var resolution_text: Label = $MarginContainer/vbox/HBoxContainer2/resolution_text
@onready var fullscreen: TextureButton = $MarginContainer/vbox/HBoxContainer/fullscreen
@onready var screen_shake: TextureButton = $MarginContainer/vbox/HBoxContainer3/screen_shake
@onready var music: TextureButton = $MarginContainer/vbox/HBoxContainer5/music
@onready var sfx: TextureButton = $MarginContainer/vbox/HBoxContainer6/sfx


var res_options := {
	1: Vector2(320, 180),
	2: Vector2(640, 360),
	3: Vector2(960, 540),
	4: Vector2(1280, 720),
	5: Vector2(1600, 900),
	6: Vector2(1920, 1080)
}
var res_selection := 5

func _ready() -> void:
	res_selection = global.res_scale
	
	if !global.music: music.button_pressed = false
	else: music.button_pressed = true
	if !global.sfx: sfx.button_pressed = false
	else: sfx.button_pressed = true
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen.button_pressed = true
	if global.screen_shake:
		screen_shake.button_pressed = true
	
	var res = res_options[res_selection]
	resolution_text.text = str(int(res.x)) + "x" + str(int(res.y))
	
	menu.pressed.connect(func():
		hide()
		main.show()
		settings.grab_focus()
	)

func set_resolution(res: Vector2) -> void:
	DisplayServer.window_set_size(res)

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	var res = res_options[res_selection]
	set_resolution(res)

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	global.screen_shake = toggled_on

func _on_resolution_pressed() -> void:
	res_selection += 1
	if res_selection > res_options.size():
		res_selection = 1
	var res = res_options[res_selection]
	resolution_text.text = str(int(res.x)) + "x" + str(int(res.y))
	set_resolution(res)
	global.res_scale = res_selection

func _on_sfx_toggled(toggled_on: bool) -> void:
	var index = AudioServer.get_bus_index("SFX")
	if toggled_on:
		AudioServer.set_bus_volume_db(index, 0)
	else:
		AudioServer.set_bus_volume_db(index, -99)
	
	global.sfx = toggled_on

func _on_music_toggled(toggled_on: bool) -> void:
	var index = AudioServer.get_bus_index("Music")
	if toggled_on:
		AudioServer.set_bus_volume_db(index, 0)
	else:
		AudioServer.set_bus_volume_db(index, -99)
	
	global.music = toggled_on
