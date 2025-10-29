@icon("res://Assets/icons/icon_hitbox.png")
class_name hurtbox_component
extends Area2D

@onready var body : base_character = owner

signal hurtbox_hit(attack : Attack, killer : Node)

func _init() -> void:
	collision_layer = 0
	collision_mask = 8

func _ready() -> void:
	area_entered.connect(hitbox_entered)

func hitbox_entered(Myhitbox : hitbox_component) -> void:
	if Myhitbox == null:
		return
	
	var target_groups = Myhitbox.target_groups
	for target in target_groups:
		if body.is_in_group(target): 
			Myhitbox.enemy_hit.emit()
			hurtbox_hit.emit(Myhitbox.attack, Myhitbox.killer)
			break
