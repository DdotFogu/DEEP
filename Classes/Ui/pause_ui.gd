extends Control
#
#@export var continue_button : Button
#@export var quit_button : Button
#
#signal paused
#signal unpaused
#
#var can_pause : bool = true
#
#func _init() -> void:
	#signal_bus.enter_transition.connect(func(): can_pause = false)
	#signal_bus.exit_transition.connect(func(): can_pause = true)
#
#func _ready() -> void:
	#if continue_button: continue_button.pressed.connect(func(): get_tree().paused = false; unpaused.emit())
	#if quit_button: quit_button.pressed.connect(func(): get_tree().quit())
#
#func _input(event: InputEvent) -> void:
	#if !can_pause: return
	#
	#if event.is_action_pressed('toggle_pause'):
		#var is_paused = !get_tree().paused
		#get_tree().paused = is_paused
		#
		#if is_paused: 
			#(func():continue_button.grab_focus()).call_deferred()
			#paused.emit()
		#else: unpaused.emit()
