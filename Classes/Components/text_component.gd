extends Label
class_name text_component

@export_group("Component Settings")
@export var dialog : Array[String]
@export var char_delay : float = 0.2
@export var finish_delay : float = 1.0

var index := 0

signal character_added
signal text_finished
signal text_started

func _ready() -> void: text = ''

func next_dialog() -> String:
	if dialog.is_empty(): return ''
	
	var index_text = dialog[index]
	index = (index + 1) % dialog.size()
	
	return index_text

func play_text():
	var new_text = next_dialog()
	if new_text == '': return
	text_started.emit()
	
	for character in new_text:
		await get_tree().create_timer(char_delay).timeout
		character_added.emit()
		text+=character
	
	await get_tree().create_timer(finish_delay).timeout
	text_finished.emit()
