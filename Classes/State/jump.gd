extends state
class_name jump

func enter(_msg:={}):
	if !body.is_on_floor():
		Transitioned.emit(self, 'idle')
		return
	
	animation.play('jump')
	body.velocity.y -= stats.jump_height

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	if body.velocity.y > 0: Transitioned.emit(self, "air")
	body.move_and_slide()
