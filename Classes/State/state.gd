extends base_component
class_name state

signal Transitioned
signal Entered

@onready var animation : AnimatedSprite2D = owner.get_node("sprite")

func enter(msg:={}):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
