extends state
class_name player_move

func enter(_msg:={}):
	animation.play('move')

func physics_update(_delta : float):
	if not body.is_on_floor():
		Transitioned.emit(self, 'air')
		return
	
	if not is_zero_approx(body.input_direction()):
		body.velocity.x = lerp(body.velocity.x, body.input_direction() * stats.max_speed, stats.acceleration * _delta)
	elif is_zero_approx(body.input_direction()):
		Transitioned.emit(self, 'idle')
	
	if Input.is_action_pressed("jump"):
		Transitioned.emit(self, 'jump')
	
	body.move_and_slide()
