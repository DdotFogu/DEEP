extends state
class_name stun

var stun_timer : Timer

func _ready() -> void:
	super()
	stun_timer = Timer.new()
	stun_timer.wait_time = 1
	add_child(stun_timer)
	
	stun_timer.timeout.connect(_stun_finished)

func enter(msg:={}):
	animation.play('stun')
	if msg.has('stun_time'):
		stun_timer.wait_time = msg['stun_time']
	if msg.has('knockback'):
		#todo fix knockback logic
		body.velocity = msg['knockback']
	stun_timer.start()

func physics_update(_delta: float):
	body.velocity += body.get_gravity() * _delta
	if body.is_on_floor(): body.velocity.x = lerpf(body.velocity.x, 0, stats.friction * _delta)
	body.move_and_slide()

func exit():
	stun_timer.stop()

func _stun_finished():
	Transitioned.emit(self, 'idle')
