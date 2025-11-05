extends base_component
class_name state

signal Transitioned
signal Entered
signal Exited

@onready var machine : state_machine = get_parent()
@onready var animation : AnimatedSprite2D = owner.get_node("sprite")

func enter(_msg:={}):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func is_active()->bool:
	return machine.current_state == self
