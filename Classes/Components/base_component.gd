extends Node
class_name base_component

@export var enabled : bool = true
@onready var body : Node = owner
var stats : StatSheet = null

func _ready() -> void:
	if body is base_character: stats = body.stats
