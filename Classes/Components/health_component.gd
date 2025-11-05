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
	if invuln or attack.damage <= 0: return
	
	took_damage.emit()
	
	health = clamp(health - attack.damage, 0, stats.max_health)
	if health == 0: die()
	
	var knockback_direction: Vector2
	if killer is CharacterBody2D:
		if killer.velocity.is_zero_approx():
			knockback_direction = Vector2(-body.global_position.direction_to(killer.global_position).x, -1)
		else:
			knockback_direction = killer.velocity
	else:
		knockback_direction = Vector2(-body.velocity.x, -1)
	
	knockback_direction = knockback_direction.normalized()
	
	#decrease health/pierce if the killer is a projectile
	if killer is base_projectile: 
		var killer_health : health_component = killer.get_node('health_component')
		if killer_health:
			killer_health.damage(attack, body) 
	
	if state_machine: state_machine.state_change('stun',
	{
		'stun_time': attack.stun_time,
		'knockback': Vector2(knockback_direction.x, -1) * attack.knockback_force,
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
