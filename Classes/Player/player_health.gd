extends health_component
class_name player_health

func _ready() -> void:
	super()
	signal_bus.player_max_health_changed.emit(stats.max_health)

func damage(attack:Attack, killer : Node):
	if invuln: return
	super(attack, killer)
	
	signal_bus.player_health_changed.emit(health)
	signal_bus.shake_cam.emit(3, 0.25)
	
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.05).timeout
	Engine.time_scale = 1

func die():
	super()
	signal_bus.player_died.emit()
