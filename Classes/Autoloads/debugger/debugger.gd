extends Node

var character_array : Array[base_character]

func _process(delta: float) -> void:
	update_character_data()

func update_character_data():
	for character in character_array:
		if character:
			if character.has_node("debug"):
				var debug_text = character.get_node("debug")
				if debug_text.visible == false: continue
				debug_text.text = ""
				
				var character_name = character.name
				debug_text.text += character_name + "\n"
				
				if character.has_node("health_component"):
					var character_hp = character.get_node("health_component").health
					debug_text.text += "hp: " + str(character_hp) + "\n"
				if character.has_node("state_machine"):
					var charcter_state = character.get_node("state_machine").current_state
					if charcter_state: debug_text.text += charcter_state.name + "\n"
				var character_position = character.global_position
				debug_text.text += str(character_position.ceil()) + "\n"
				var character_velocity = character.velocity
				debug_text.text += str(character_velocity.ceil()) + "\n"
