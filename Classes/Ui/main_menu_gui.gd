extends CanvasLayer

@onready var arrow: AnimatedSprite2D = $arrow

var last_focus_owner: Control = null
signal focus_changed

func _process(_delta: float) -> void:
	var focus_owner = get_viewport().gui_get_focus_owner()
	if focus_owner != last_focus_owner and focus_owner != null:
		last_focus_owner = focus_owner
		focus_changed.emit()
		arrow.position = focus_owner.global_position + Vector2(
			focus_owner.size.x + 5,
			focus_owner.size.y / 1.9
		)
