extends state
class_name ghost_move

var move_dir : int

func _init() -> void:
	move_dir = 1 if randf() > 0.5 else -1

func _ready() -> void:
	super()
	animation.flip_h = true if move_dir == -1 else false

func physics_update(_delta: float):
	body.velocity.x = lerpf(body.velocity.x, stats.max_speed * move_dir, stats.acceleration * _delta)
	body.move_and_slide()
	
	if body.is_on_wall():
		move_dir = -move_dir
		animation.flip_h = true if move_dir == -1 else false
