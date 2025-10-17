extends base_component
class_name health_component

@export var state_machine : state_machine

var health : int
var invuln : bool = false

signal took_damage
signal death

var invuln_timer : Timer

func _ready() -> void: 
	super()
	health = stats.max_health
	
	invuln_timer = Timer.new()
	invuln_timer.wait_time = stats.invuln_time
	add_child(invuln_timer)
	
	invuln_timer.timeout.connect(_invuln_over)

func damage(attack : Attack):
	if invuln: return
	
	took_damage.emit()
	
	health = clampi(health - attack.damage, 0, stats.max_health)
	if health == 0: die()
	
	var killer_direction := Vector2.ONE
	if attack.killer:
		killer_direction = attack.killer.global_position.direction_to(body.global_position).normalized()
	
	if state_machine: state_machine.state_change('stun',
	{
		'stun_time': attack.stun_time,
		'knockback': attack.knockback_direction * Vector2(-killer_direction.x, killer_direction.y),
	})
	
	invuln = true
	invuln_timer.start()

func die():
	death.emit()

func _invuln_over():
	invuln_timer.stop()
	invuln = false
