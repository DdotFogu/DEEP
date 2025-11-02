extends state
class_name crawler_move

signal entered_ceil
signal exited_ceil

var on_ceil : bool = false:
	set(new_boolean):
		on_ceil = new_boolean
		if new_boolean == true: entered_ceil.emit()
		elif new_boolean == false: exited_ceil.emit()

enum direction {RIGHT, LEFT}

@export var crawl_direction = direction.RIGHT

var snap_vector := Vector2.DOWN
var move_vector := Vector2.RIGHT

func enter(_msg := {}):
	Entered.emit()
	animation.play('move')
	
	if crawl_direction == 0:
		move_vector = Vector2.RIGHT
	if crawl_direction == 1:
		move_vector = Vector2.LEFT

func set_velocity_snap_and_rotation(collision):
	var normal = collision.get_normal()
	if crawl_direction == 0:
		move_vector = normal.rotated(PI/2)
		body.rotation = move_vector.angle()
	if crawl_direction == 1:
		move_vector = -normal.rotated(PI/2)
		body.rotation = move_vector.angle() + PI
	snap_vector = normal.rotated(PI)

func random_crawl_direction()->void:
	crawl_direction = randi_range(direction.RIGHT, direction.LEFT)

func physics_update(_delta: float):
	body.velocity = move_vector * stats.max_speed
	body.move_and_slide()
	
	if body.is_on_ceiling() != on_ceil: on_ceil = body.is_on_ceiling()
	
	var collision = body.get_last_slide_collision()
	if collision != null:
		set_velocity_snap_and_rotation(collision)
	else:
		if !body.is_on_floor() and !body.is_on_wall() and !body.is_on_ceiling() and body.velocity:
			move_vector = -move_vector + snap_vector
