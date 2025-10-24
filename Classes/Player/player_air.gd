extends air

func physics_update(_delta : float):
	super(_delta)
	if not is_zero_approx(body.input_direction()):
		body.velocity.x = lerp(body.velocity.x, body.input_direction() * stats.max_speed, stats.acceleration * _delta)
