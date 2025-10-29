@icon("res://Assets/icons/icon_event.png")
extends Area2D
class_name pickup_component

signal pickup

@export var active := true

func _ready() -> void:
	body_entered.connect(item_pickup)

func item_pickup(_body: Node2D):
	if !active: return
	pickup.emit()
