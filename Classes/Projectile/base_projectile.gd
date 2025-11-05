@icon("res://Assets/icons/icon_bullet.png")
extends base_character
class_name base_projectile

@export var proj_stats : ProjStatSheet

signal lifetime_over
signal proj_reset

var lifetime_timer : Timer
var grace_timer : Timer

func _ready() -> void:
	super()
	
	grace_timer = Timer.new()
	grace_timer.wait_time = 0.1
	grace_timer.timeout.connect(func():
		grace_timer.stop()
		)
	add_child(grace_timer)
	
	lifetime_timer = Timer.new()
	lifetime_timer.timeout.connect(lifetime_finished)
	add_child(lifetime_timer)

func lifetime_finished():
	lifetime_over.emit()
	lifetime_timer.stop()

func reset_proj(): 
	grace_timer.start()
	lifetime_timer.wait_time = proj_stats.lifetime
	lifetime_timer.start()
	proj_reset.emit()

func _process(_delta: float) -> void:
	if proj_stats.wall_destory and get_last_slide_collision() and grace_timer.is_stopped(): 
		lifetime_over.emit()
	
	var normal = velocity.normalized()
	var sprite : AnimatedSprite2D = get_node('sprite')
	
	if !sprite: return
	if normal.x > 0: sprite.flip_h = false
	if normal.x < 0: sprite.flip_h = true
