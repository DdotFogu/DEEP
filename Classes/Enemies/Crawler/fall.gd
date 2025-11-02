extends state

signal landed_on_floor
signal continued

@export var delay_time : float = 3.0
@export var after_state : String
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = delay_time
	timer.timeout.connect(func():
		Transitioned.emit(self, after_state)
		)
	add_child(timer)

func enter(_msg:={}):
	body.rotation = 0.0
	body.velocity = Vector2.ZERO
	animation.play('fall')

func exit(): continued.emit()

func physics_update(_delta : float):
	body.velocity += body.get_gravity() * _delta
	body.move_and_slide()
	
	if body.is_on_floor() and timer.is_stopped():
		timer.start()
		landed_on_floor.emit()
