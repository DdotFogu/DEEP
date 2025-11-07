extends dead
class_name ghost_dead

func spawn_skull():
	if !global.current_level: return
	
	var skull = preload("res://Classes/Enemies/Skull/skull.tscn").instantiate()
	skull.global_position = body.global_position
	global.current_level.add_child(skull)

func physics_update(_delta : float):
	body.velocity = lerp(body.velocity, Vector2.ZERO, stats.friction * _delta)
	body.move_and_slide()
