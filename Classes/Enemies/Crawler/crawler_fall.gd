extends state

signal landed_on_floor
signal wait_timer_timeout

@export var delay_time : float = 3.0
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = delay_time
	timer.timeout.connect(func():
		wait_timer_timeout.emit()
		)
	add_child(timer)

func enter(_msg:={}):
	body.rotation = 0.0
	body.velocity = Vector2.ZERO
	animation.play('fall')

func exit(): 
	timer.stop()

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	body.move_and_slide()
	
	if body.is_on_floor() and timer.is_stopped():
		animation.play('land')
		signal_bus.shake_cam.emit(1, 0.25)
		timer.start()
		landed_on_floor.emit()
