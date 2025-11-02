extends base_component
class_name projectile_component

@export_group("Component Stats")
@export var max_ammo := 1:
	set(new_max):
		max_ammo = new_max
		max_ammo_set()

@export_group("Component Settings")
@export var proj_scene : PackedScene
@export var spawn_offset := Vector2.ZERO

var proj_stack : Array = []
var ammo : int:
	set(new_amount):
		ammo = new_amount
		ammo = clampi(new_amount, 0, max_ammo)
		current_ammo_set()

signal projectile_fired

func _ready() -> void:
	ammo = max_ammo
	max_ammo_set()
	current_ammo_set()

func spawn_projectile(move_direction : Vector2, req_ammo:bool=true):
	if !enabled: return
	if req_ammo and ammo == 0: return
	
	projectile_fired.emit()
	var proj : base_projectile
	
	if proj_stack.is_empty():
		proj = proj_scene.instantiate()
		proj.lifetime_over.connect(add_proj_to_stack.bind(proj))
		get_tree().root.add_child(proj)
	else: proj = proj_stack.pop_front()
	
	proj.global_position = body.global_position + (Vector2(spawn_offset.x * move_direction.x, spawn_offset.y))
	proj.get_node('state_machine').state_change('move', 
	{'move_direction': move_direction})
	
	proj.reset_proj()
	
	if req_ammo: ammo -= 1

func add_proj_to_stack(proj_to_add):
	if proj_stack.has(proj_to_add): return
	proj_stack.push_back(proj_to_add)

func add_ammo(amount:int=1):
	ammo += amount
	return ammo

func max_ammo_set():
	pass

func current_ammo_set():
	pass
