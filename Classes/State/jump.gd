extends state
class_name player_jump

func enter(_msg:={}):
	animation.play('jump')
	body.velocity.y -= stats.jump_height

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	
	if not is_zero_approx(body.input_direction()):
		body.velocity.x = lerp(body.velocity.x, body.input_direction() * stats.max_speed, stats.acceleration * _delta)
	
	if body.velocity.y > 0: Transitioned.emit(self, "air")
	
	body.move_and_slide()
