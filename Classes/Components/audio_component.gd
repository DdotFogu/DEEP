extends base_component
class_name audio_component

func play_audio(audio_name : String, pitch_scale := Vector2(0.9,1.1)):
	if !audio_name: return
	audio.play_sound(audio_name, pitch_scale)

func toggle_audio(audio_name : String, toggle : bool = false):
	if !audio_name: return
	audio.toggle_sound(audio_name, toggle)
