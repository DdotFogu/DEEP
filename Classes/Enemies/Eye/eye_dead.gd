extends dead
class_name eye_dead

func physics_update(_delta : float):
	body.velocity.x = lerpf(body.velocity.x, 0.0, stats.friction * _delta)
	body.move_and_slide()
