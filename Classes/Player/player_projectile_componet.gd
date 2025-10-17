extends projectile_component

func _process(delta: float) -> void: if Input.is_action_just_pressed("fire_weapon"): spawn_projectil()
