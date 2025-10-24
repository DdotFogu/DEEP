extends idle
class_name player_idle

func enter(msg:={}):
	animation.play('idle')

func physics_update(_delta : float):
	super(_delta)
	
	if Input.is_action_pressed("jump"):
		Transitioned.emit(self, 'jump')
	if not is_zero_approx(body.input_direction()):
		Transitioned.emit(self, 'move')
