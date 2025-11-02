extends interact_component
class_name pickup_component

@export var on_enter : bool = false

func _ready() -> void:
	if on_enter:
		target_enetered.connect(item_pickup)
	else:
		interact.connect(item_pickup)

func item_pickup():
	pass
