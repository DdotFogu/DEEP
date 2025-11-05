extends jump
class_name frog_jump

var jump_dir : int

func _ready() -> void:
	super()
	jump_dir = -1 if randf() < 0.5 else 1

func enter(_msg := {}):
	super(_msg)
	
	if jump_dir == -1: animation.flip_h = true 
	else: animation.flip_h = false
	
	body.velocity.x += stats.max_speed * jump_dir

func physics_update(_delta : float):
	super(_delta)
	if body.is_on_wall(): 
		body.velocity.x += stats.max_speed * -jump_dir # push away from wall
		if jump_dir == -1: animation.flip_h = false 
		else: animation.flip_h = true
		
		jump_dir = -jump_dir
