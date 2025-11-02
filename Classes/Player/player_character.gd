extends base_character
class_name player_character

func _init() -> void: global.player = self

func input_direction() -> int:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return direction

func _process(_delta: float) -> void:
	if signal_bus.player_dead: return
	if !animation: return
	
	if Input.is_action_pressed('move_right'):
		animation.flip_h = false
	elif Input.is_action_pressed('move_left'):
		animation.flip_h = true
