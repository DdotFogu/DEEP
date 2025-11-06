extends Control

@onready var menu: TextureButton = $MarginContainer/vbox/menu
@onready var main: Control = $"../main"
@onready var settings: TextureButton = $"../main/MarginContainer/vbox/settings"
@onready var resolution_text: Label = $MarginContainer/vbox/HBoxContainer2/resolution_text
@onready var sfx_text: Label = $MarginContainer/vbox/HBoxContainer4/text
@onready var music_text: Label = $MarginContainer/vbox/HBoxContainer5/text

var res_options := {
	1: Vector2(320, 180),
	2: Vector2(640, 360),
	3: Vector2(960, 540),
	4: Vector2(1280, 720),
	5: Vector2(1600, 900),
	6: Vector2(1920, 1080)
}
var res_selection := 5

var volume_options := {
	1: 0,
	2: 25,
	3: 50,
	4: 75,
	5: 100
}
var sfx_volume_selection := 5
var music_volume_selection := 5

func _ready() -> void:
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

func _on_screen_shake_toggled(toggled_on: bool) -> void:
	global.screen_shake = toggled_on

func _on_resolution_pressed() -> void:
	res_selection += 1
	if res_selection > res_options.size():
		res_selection = 1
	var res = res_options[res_selection]
	resolution_text.text = str(int(res.x)) + "x" + str(int(res.y))
	set_resolution(res)

func set_bus_volume(bus_name: String, percent: float) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	if bus_index == -1:
		return #
	var db = linear_to_db(percent / 100.0)
	AudioServer.set_bus_volume_db(bus_index, db)

func _on_sfx_volume_pressed() -> void:
	sfx_volume_selection += 1
	if sfx_volume_selection > volume_options.size():
		sfx_volume_selection = 1
	var vol = volume_options[sfx_volume_selection]
	sfx_text.text = str(int(vol)) + "%"
	set_bus_volume("SFX", vol)

func _on_music_volume_pressed() -> void:
	music_volume_selection += 1
	if music_volume_selection > volume_options.size():
		music_volume_selection = 1
	var vol = volume_options[music_volume_selection]
	music_text.text = str(int(vol)) + "%"
	set_bus_volume("Music", vol)
