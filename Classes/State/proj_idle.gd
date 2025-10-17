extends state
class_name proj_idle

func enter(_msg:={}):
	animation.play('idle')

func physics_update(_delta : float):
	body.velocity.x = lerpf(body.velocity.x, 0, stats.friction * _delta)
	body.move_and_slide()
