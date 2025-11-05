extends state
class_name stun

var stun_timer : Timer
var freeze : bool = false

func _ready() -> void:
	super()
	stun_timer = Timer.new()
	stun_timer.wait_time = 1
	add_child(stun_timer)
	
	stun_timer.timeout.connect(_stun_finished)

func enter(msg:={}):
	Entered.emit()
	animation.play('stun')
	if msg.has('stun_time'):
		stun_timer.wait_time = msg['stun_time']
	if msg.has('knockback'):
		body.velocity = msg['knockback']
	if msg.has('freeze'):
		freeze = msg['freeze']
	stun_timer.start()

func physics_update(_delta: float):
	if freeze: return
	
	body.velocity += body.get_gravity() * _delta
	if body.is_on_floor(): body.velocity.x = lerpf(body.velocity.x, 0, stats.friction * _delta)
	body.move_and_slide()

func exit():
	Exited.emit()
	freeze = false
	stun_timer.stop()

func _stun_finished():
	Transitioned.emit(self, 'idle')
