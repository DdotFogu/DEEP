extends HBoxContainer

const heart_scene := preload("res://Classes/Ui/heart.tscn")

func _init() -> void:
	signal_bus.player_max_health_changed.connect(set_max_hearts)
	signal_bus.player_health_changed.connect(update_hearts)

func set_max_hearts(max_amount: int):
	for i in range(max_amount):
		var heart = heart_scene.instantiate()
		add_child(heart)

func update_hearts(current_health : int):
	var hearts = get_children()
	
	for i in range(current_health):
		if i+1 > hearts.size(): return
		
		var heart_animation = hearts[i].get_node('animation')
		heart_animation.play('idle')
	
	for i in range(current_health, hearts.size()):
		var heart_animation = hearts[i].get_node('animation')
		heart_animation.play('empty')
