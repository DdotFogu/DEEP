extends projectile_component
class_name player_projectile

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon") and enabled: 
		spawn_projectile(Vector2(body.face_direction().x, 0))

func max_ammo_set():
	super()
	signal_bus.player_max_ammo_changed.emit(max_ammo)

func current_ammo_set():
	super()
	signal_bus.player_ammo_changed.emit(ammo)
