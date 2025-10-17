extends base_component
class_name projectile_component

@export var proj_scene : PackedScene
@export var spawn_offset := Vector2.ZERO
@export var can_fire : bool = true

var proj_stack : Array = []

signal projectile_fired

func spawn_projectil():
	if !can_fire: return
	
	projectile_fired.emit()
	var proj : base_projectile
	
	if proj_stack.is_empty():
		proj = proj_scene.instantiate()
		proj.lifetime_over.connect(add_proj_to_stack.bind(proj))
		get_tree().root.add_child(proj)
	else: proj = proj_stack.pop_front()
	
	proj.global_position = body.global_position + (spawn_offset * body.face_direction().x)
	proj.get_node('state_machine').state_change('move', 
	{'move_direction': Vector2(body.face_direction().x, 0)})
	
	proj.reset_proj()

func add_proj_to_stack(proj_to_add):
	if proj_stack.has(proj_to_add): return
	proj_stack.push_back(proj_to_add)
