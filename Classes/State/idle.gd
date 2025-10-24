extends state
class_name idle

func enter(msg:={}):
	animation.play('idle')

func physics_update(_delta : float):
	if not body.is_on_floor():
		Transitioned.emit(self, 'air'); return
	
	body.velocity.x = lerpf(body.velocity.x, 0, stats.friction * _delta)
	body.move_and_slide()
