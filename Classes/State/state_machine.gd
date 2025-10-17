extends Node
class_name state_machine

@export var initial_state : state

var current_state : state
var states : Dictionary = {}

func state_change(new_state : String, msg:={}):
	current_state.Transitioned.emit(current_state, new_state, msg)
	
	if current_state.name == new_state: return true

func _ready():
	for child in get_children():
		if child is state:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name, msg:={}):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter(msg)
	
	current_state = new_state
