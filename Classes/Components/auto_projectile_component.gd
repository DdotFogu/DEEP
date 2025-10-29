extends projectile_component
class_name auto_projectile_component

@export var direction := Vector2(1, 0)
@export var wait_time : float = 1.0
@export var use_ammo : bool = true
var timer : Timer

func _ready() -> void:
	super()
	
	timer = Timer.new()
	timer.wait_time = wait_time
	timer.autostart = true
	timer.timeout.connect(timer_timeout)
	add_child(timer)

func timer_timeout():
	timer.wait_time = wait_time
	spawn_projectile(direction, use_ammo)
