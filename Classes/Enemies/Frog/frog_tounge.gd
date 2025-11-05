extends state
class_name frog_tongue

@export var projectile_component: projectile_component
@export var tongue_delay: float = 1.0
@export var tongue_line: Line2D

var tongue_timer: Timer
var current_proj: base_projectile
var in_pull := false
var active_tween: Tween

func _ready() -> void:
	super()
	
	tongue_timer = Timer.new()
	tongue_timer.one_shot = true
	tongue_timer.wait_time = tongue_delay
	tongue_timer.timeout.connect(shoot_tongue)
	add_child(tongue_timer)

func enter(_msg := {}):
	Entered.emit()
	tongue_timer.start()
	if current_proj: current_proj.global_position = body.global_position

func exit():
	Exited.emit()
	if tongue_timer: tongue_timer.stop()
	if active_tween and active_tween.is_valid(): active_tween.kill()
	if current_proj: current_proj.lifetime_finished()
	in_pull = false

func update(_delta: float):
	var dir = body.global_position.direction_to(global.player.global_position)
	animation.flip_h = dir.x < 0
	
	if tongue_line:
		if current_proj:
			tongue_line.points = [Vector2.ZERO, body.to_local(current_proj.global_position)]
		else: tongue_line.points = []

func physics_update(_delta: float):
	if !body.is_on_floor():
		body.velocity += body.get_gravity() * _delta
	
	body.velocity.x = lerpf(body.velocity.x, 0.0, stats.friction * _delta)
	body.move_and_slide()

func shoot_tongue():
	if !is_active(): return
	animation.play('tongue')
	await get_tree().create_timer(0.5).timeout
	if !is_active(): return
	
	var dir = body.global_position.direction_to(global.player.global_position)
	current_proj = projectile_component.spawn_projectile(dir, false)
	
	var proj_hitbox: target_detection_component = current_proj.get_node('player_component')
	proj_hitbox.monitoring = true
	proj_hitbox.target_entered.connect(func():
		pull_tongue(global.player)
	)
	
	var wall_detection = current_proj.get_node('wall_component')
	wall_detection.target_entered.connect(func():
		pull_tongue()
	)

func pull_tongue(collider: base_character = null):
	if in_pull or !is_active(): return
	in_pull = true
	current_proj.state_machine.state_change('idle', {})
	
	active_tween = create_tween().set_parallel()
	active_tween.tween_property(current_proj, 'global_position', body.global_position, 0.5)
	if collider:
		active_tween.tween_property(collider, 'global_position', body.global_position, 0.5)
	await active_tween.finished
	
	current_proj.lifetime_finished()
	Transitioned.emit(self, 'idle')
	in_pull = false
