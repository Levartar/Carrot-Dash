extends Node2D

const speed = 700
var current_speed = speed

func _process(delta):
	#Mold doesnt fall back
	var pos = get_node("/root/Game/Player").position.x-1000
	if pos>position.x:
		position.x = pos
	else:
		position.x += current_speed * delta
	
func speed_wall():
	print("wallboost")
	current_speed = speed+300
	await get_tree().create_timer(2.0).timeout
	current_speed = speed
	
func slow_wall():
	print("wallboost")
	current_speed = 200
	await get_tree().create_timer(2.0).timeout
	current_speed = speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("loose Game")
