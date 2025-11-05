extends base_component
class_name auido_component

func play_audio(audio_name : String):
	if !audio_name: return
	audio.play_audio(audio_name)
