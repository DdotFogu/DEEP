@icon("res://Assets/icons/icon_particle.png")
extends Node2D
class_name particle_component

@export var particles : Dictionary

func _ready() -> void:
	for particle in get_children():
		particles[particle.name] = particle

func play_particle(particle_name : String):
	if particle_name not in particles: return null
	particles[particle_name].restart()
	particles[particle_name].emitting = true

func stop_particle(particle_name : String):
	if particle_name not in particles: return null
	particles[particle_name].emitting = false
