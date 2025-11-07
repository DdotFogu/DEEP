extends health_component
class_name player_health

func _ready() -> void:
	super()
	signal_bus.player_max_health_changed.emit(stats.max_health)

func damage(attack:Attack, killer : Node):
	if invuln or attack.damage <= 0: return
	super(attack, killer)
	
	signal_bus.player_health_changed.emit(health)
	signal_bus.shake_cam.emit(3, 0.4)

func die():
	super()
	signal_bus.player_died.emit()
