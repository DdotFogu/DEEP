extends CanvasLayer

@onready var animation : AnimationPlayer = get_node('transition_ui/AnimationPlayer')

func transition_scene(scene_packed : PackedScene):
	await await_transition()
	change_scene(scene_packed)

func change_scene(scene_packed : PackedScene):
	if scene_packed == null: return
	get_tree().change_scene_to_packed(scene_packed)

func await_transition():
	get_tree().paused = true
	animation.play_backwards('progress'); await animation.animation_finished
	animation.play('progress'); get_tree().paused = false
