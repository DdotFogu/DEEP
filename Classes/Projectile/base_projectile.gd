@icon("res://Assets/icons/icon_bullet.png")
extends base_character
class_name base_projectile

@export var proj_stats : ProjStatSheet

signal lifetime_over
signal proj_reset

func _ready() -> void: start_lifetime()

func start_lifetime():
	await get_tree().create_timer(proj_stats.lifetime).timeout
	lifetime_over.emit()

func reset_proj(): 
	start_lifetime()
	proj_reset.emit()

func _process(delta: float) -> void:
	var normal = velocity.normalized()
	var sprite : AnimatedSprite2D = get_node('sprite')
	
	if !sprite: return
	if normal.x > 0: sprite.flip_h = false
	if normal.x < 0: sprite.flip_h = true
