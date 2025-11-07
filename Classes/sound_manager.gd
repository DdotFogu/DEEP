extends Node

var sounds : Dictionary

func _ready() -> void:
	
	for sound in get_children().filter(func(child): return child is AudioStreamPlayer):
		sounds[sound.name] = sound

func play_sound(sound_name : String, pitch_scale := Vector2(0.9, 1.1)):
	if sound_name not in sounds.keys(): return
	else: 
		sounds[sound_name].pitch_scale = 1 * randf_range(pitch_scale.x, pitch_scale.y)
		sounds[sound_name].play()

func toggle_sound(sound_name : String, toggle : bool = false):
	if sound_name not in sounds.keys(): return
	else: 
		sounds[sound_name].stream_paused  = !toggle
