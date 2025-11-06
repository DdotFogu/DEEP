extends CanvasLayer

@onready var arrow: AnimatedSprite2D = $arrow

func _process(delta: float) -> void:
	arrow.position = get_viewport().gui_get_focus_owner().global_position + Vector2(
		get_viewport().gui_get_focus_owner().size.x + 5, get_viewport().gui_get_focus_owner().size.y / 1.9)
