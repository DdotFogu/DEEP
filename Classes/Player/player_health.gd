extends health_component
class_name player_health

func _ready() -> void:
	super()
	signal_bus.player_max_health_changed.emit(stats.max_health)

func damage(attack:Attack, killer : Node):
	super(attack, killer)
	signal_bus.player_health_changed.emit(health)
