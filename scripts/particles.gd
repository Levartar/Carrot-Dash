extends Node2D

func _ready():
	for child in get_children():
		if child is CPUParticles2D:
			child.visible = true
			child.amount = 100

func toggle_particles():
	for child in get_children():
		if child is CPUParticles2D:
			#child.visible = false
			child.lifetime = 1
