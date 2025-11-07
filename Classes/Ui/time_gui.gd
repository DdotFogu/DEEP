extends Label

var t: float = 0.0

func _process(delta: float) -> void:
	if signal_bus.player_dead: return
	
	t += delta
	text = "time : %.1f" % t
	global.current_time = t
