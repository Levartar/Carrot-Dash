extends Node2D

const speed = 400

func _process(delta):
	position.x += speed * delta
