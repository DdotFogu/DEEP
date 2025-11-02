extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer

func _init() -> void:
	global.transition_ui = self
	
	signal_bus.enter_transition.connect(func(): 
		animation.play_backwards('progress') 
		await animation.animation_finished
		animation.play('progress'); get_tree().paused = false
	)

func transition_scene(scene_packed : PackedScene):
	get_tree().paused = true
	await await_transition()
	change_scene(scene_packed)

func change_scene(scene_packed : PackedScene):
	if scene_packed == null: return
	get_tree().change_scene_to_packed(scene_packed)

func await_transition():
	signal_bus.enter_transition.emit()
	await animation.animation_finished
	signal_bus.exit_transition.emit()
