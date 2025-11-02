extends projectile_component
class_name player_projectile

func _unhandled_input(event: InputEvent) -> void:
	if !enabled or ammo == 0: return
	if event.is_action_pressed("fire_weapon"): 
		spawn_projectile(Vector2(body.face_direction().x, 0))
		signal_bus.shake_cam.emit(1, 0.25)

func max_ammo_set():
	super()
	signal_bus.player_max_ammo_changed.emit(max_ammo)

func current_ammo_set():
	super()
	signal_bus.player_ammo_changed.emit(ammo)
