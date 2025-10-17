extends state
class_name projectile_move

var move_direction := Vector2.ZERO

func enter(msg:={'move_direction': Vector2(1, 0)}):
	if msg.has('move_direction'):
		move_direction = msg['move_direction']

func physics_update(_delta: float) -> void:
	body.velocity = lerp(body.velocity, move_direction * stats.max_speed, stats.acceleration * _delta)
	body.move_and_slide()
