extends Node2D

func _ready():
	for child in get_children():
		if child is CPUParticles2D:
			child.visible = true
			child.amount = 16
			
