extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body._on_damage_area_2d_body_entered(body)
		get_node("/root/Game/MoldWall").speed_wall()
