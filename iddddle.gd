extends idle

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	print(body.velocity.x)
