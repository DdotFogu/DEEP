extends target_detection_component
class_name interact_component

@export_group('Component Settings')
@export var enabled : bool = true

var cursor : AnimatedSprite2D

signal interact

func _init() -> void:
	super()
	target_entered.connect(toggle_cursor.bind(true))
	target_exited.connect(toggle_cursor.bind(false))

func _ready() -> void:
	super()
	
	if has_node('arrow'): 
		cursor = get_node('arrow')
		cursor.visible = false

func toggle_cursor(enable := true):
	if !cursor: return
	cursor.visible = enable

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("interact"): return
	if !enabled: return
	
	var collider = get_overlapping_bodies()
	if collider.is_empty(): return
	
	if has_los(collider[0]):
		interact.emit()
