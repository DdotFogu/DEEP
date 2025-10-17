extends state
class_name air

func enter(_msg:={}):
	animation.play('air')

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	body.move_and_slide()
	
	if not is_zero_approx(body.input_direction()):
		body.velocity.x = lerp(body.velocity.x, body.input_direction() * stats.max_speed, stats.acceleration * _delta)
	
	if body.is_on_floor():
		Transitioned.emit(self, 'idle')
