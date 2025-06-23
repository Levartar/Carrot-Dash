extends Node2D


@onready var player:Player = get_node("/root/Game/Player")
const speed = 700
var current_speed = speed

func _process(delta):
	#Mold doesnt fall back
	if !player.stop:
		var pos = player.position.x-1000
		if pos>position.x:
			position.x = pos
		else:
			position.x += current_speed * delta
	else:
		$Particles.toggle_particles()
	
func speed_wall():
	print("wallboost")
	current_speed = speed+300
	await get_tree().create_timer(2.0).timeout
	current_speed = speed
	
func slow_wall():
	current_speed = 200
	await get_tree().create_timer(2.0).timeout
	current_speed = speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.loose_game(body)
		print("moldloose")
