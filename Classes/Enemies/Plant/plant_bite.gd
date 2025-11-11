extends state
class_name plant_bite

@onready var vine: Line2D = $"../../vine"

func enter(msg:={}):
	Entered.emit()
	
	animation.play('bite')
	
	var space_state = body.get_world_2d().direct_space_state
	
	var start = body.global_position
	var end = start + Vector2(0, 150)
	var query = PhysicsRayQueryParameters2D.create(start, end, 2)
	query.exclude = [body]
	
	var result = space_state.intersect_ray(query)
	
	if result:
		var local_hit_pos = body.to_local(result["position"]) + Vector2(0, -5)
		var tween : Tween = get_tree().create_tween()
		
		await tween.tween_property(animation, "position", local_hit_pos, 1).finished
		signal_bus.shake_cam.emit(3, 0.25)
		audio.play_sound('crawler_land')
		
		tween = get_tree().create_tween()
		tween.tween_property(animation, "position", Vector2.ZERO, 3)
		await tween.finished
	else: 
		await get_tree().create_timer(0.5).timeout
	
	Transitioned.emit(self, 'idle')

func update(_delta):
	vine.points[0] = Vector2.ZERO
	vine.points[1] = animation.position

func exit():
	Exited.emit()
