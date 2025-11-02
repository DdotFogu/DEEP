extends state
class_name air

@export var after_state : String = 'idle'

func enter(_msg:={}):
	animation.play('air')

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	body.move_and_slide()
	
	if body.is_on_floor():
		Transitioned.emit(self, after_state)
