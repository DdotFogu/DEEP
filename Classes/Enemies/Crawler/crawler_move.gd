extends state
class_name crawler_move

@export var move_direction := Vector2(1, 0)

func enter(msg:={}):
	animation.play('move')
	
	if msg.has('move_direction'):
		move_direction = msg['move_direction']

func physics_update(_delta : float):
	if not body.is_on_floor():
		Transitioned.emit(self, 'air')
		return
	
	body.velocity = lerp(body.velocity, move_direction * stats.max_speed, stats.acceleration * _delta)
	body.move_and_slide()
