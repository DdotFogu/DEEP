extends Node

var sounds : Dictionary

func _ready() -> void:
	
	for sound in get_children().filter(func(child): return child is AudioStreamPlayer):
		sounds[sound.name] = sound

func play_sound(sound_name: String, pitch_scale := Vector2(0.9, 1.1)) -> void:
	if sound_name not in sounds: 
		return

	var min_pitch = min(pitch_scale.x, pitch_scale.y)
	var max_pitch = max(pitch_scale.x, pitch_scale.y)
	var random_pitch = randf_range(min_pitch, max_pitch)
	sounds[sound_name].pitch_scale = max(random_pitch, 0.01) # ensure > 0
	sounds[sound_name].play()


func toggle_sound(sound_name : String, toggle : bool = false):
	if sound_name not in sounds.keys(): return
	else: 
		sounds[sound_name].stream_paused  = !toggle
