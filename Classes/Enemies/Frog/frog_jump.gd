extends jump
class_name frog_jump

@export var launch_range := Vector2(50, 50)
@export var jump_intesity := Vector2(1.0, 1.5)
@export var wait_time := 1.0
@export var jump_delay := 1.0
var jump_timer : Timer

func _ready() -> void: 
	super()
	jump_timer = Timer.new()
	jump_timer.wait_time = wait_time * randf()
	jump_timer.autostart = true
	jump_timer.timeout.connect(func():
		if body.is_on_floor():
			Transitioned.emit(machine.current_state, 'jump')
			jump_timer.stop()
			await get_tree().create_timer(jump_delay).timeout
			jump_timer.wait_time = wait_time * randf_range(0.0, 2.0)
			jump_timer.start()
		)
	add_child(jump_timer)

func enter(_msg:={}):
	
	animation.play('jump')
	
	var jump_direction = body.global_position.direction_to(global.player.global_position).normalized()
	var jump_offset := Vector2(randf_range(launch_range.x, launch_range.y),-stats.jump_height * randf_range(jump_intesity.x, jump_intesity.y))
	var jump_velocity := Vector2(jump_offset.x * jump_direction.x, jump_offset.y)
	
	animation.flip_h = false if jump_direction.x > 0 else true
	body.velocity = jump_velocity
