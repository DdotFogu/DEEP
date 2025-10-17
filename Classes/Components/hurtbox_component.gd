@icon("res://Assets/icons/icon_hitbox.png")
class_name hurtbox_component
extends Area2D

@onready var body : base_character = owner

signal hurtbox_hit(attack : Attack)

func _init() -> void:
	collision_layer = 0
	collision_mask = 8

func _ready() -> void:
	area_entered.connect(hitbox_entered)

func hitbox_entered(Myhitbox : hitbox_component) -> void:
	if Myhitbox == null:
		return
	
	var target_group = Myhitbox.target_group
	if !body.is_in_group(target_group):
		print(str(target_group) + " =? " + str(body.name)); return
	
	Myhitbox.enemy_hit.emit()
	
	var attack = Attack.new()
	attack.stun_time = Myhitbox.stun_time
	attack.damage = Myhitbox.damage
	attack.killer = Myhitbox.killer
	attack.knockback_direction = Myhitbox.knockback_direction
	
	hurtbox_hit.emit(attack)
