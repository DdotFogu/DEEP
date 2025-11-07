extends Label

func _init() -> void:
	signal_bus.floor_level_changed.connect(update_floor_title)

func update_floor_title(level:int=0, flavor:String='dungeon - '):
	text = flavor + str(level)
