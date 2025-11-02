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
	invuln_timer.timeout.connect(_invuln_over)
	add_child(invuln_timer)

#TODO: split knockback into its own component
func damage(attack : Attack,  killer : Node):
	if invuln: return
	
	took_damage.emit()
	
	health = clamp(health - attack.damage, 0, stats.max_health)
	if health == 0: die()
	
	var knockback_direction := Vector2(-body.velocity.normalized().x, -1)
	if killer is CharacterBody2D and killer.velocity.is_zero_approx(): knockback_direction = killer.velocity.normalized()
	
	if state_machine: state_machine.state_change('stun',
	{
		'stun_time': attack.stun_time,
		'knockback': Vector2(knockback_direction.x, -abs(knockback_direction.y)) * attack.knockback_force,
	})
	
	if stats.invuln_time>0:
		invuln = true
		invuln_timer.wait_time = stats.invuln_time
		invuln_timer.start()

func die():
	(func():death.emit()).call_deferred()

func _invuln_over():
	invuln_timer.stop()
	invuln = false

func reset_health():
	health = stats.max_health
