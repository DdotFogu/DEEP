extends projectile_component
class_name player_projectile

func _process(delta: float) -> void: 
	if Input.is_action_just_pressed("fire_weapon"): spawn_projectil()

func max_ammo_set():
	super()
	signal_bus.player_max_ammo_changed.emit(max_ammo)

func current_ammo_set():
	super()
	signal_bus.player_ammo_changed.emit(ammo)
