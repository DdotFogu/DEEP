extends state
class_name dead

func enter(_msg:={}):
	Entered.emit()
	animation.play('dead')

func physics_update(_delta : float):
	body.velocity.x = lerpf(body.velocity.x, 0.0, stats.friction * _delta)
	body.velocity += body.get_gravity() * _delta
	body.move_and_slide()
