extends stun
class_name eye_stun

func enter(msg:={}):
	Entered.emit()
	animation.play('stun')
	if msg.has('stun_time'):
		stun_timer.wait_time = msg['stun_time']
	if msg.has('freeze'):
		freeze = msg['freeze']
	stun_timer.start()

func physics_update(_delta: float):
	if freeze: return
	
	if body.is_on_floor(): body.velocity.x = lerpf(body.velocity.x, 0, stats.friction * _delta)
	body.move_and_slide()
