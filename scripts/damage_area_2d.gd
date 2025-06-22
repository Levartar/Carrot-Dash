extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body._on_damage_area_2d_body_entered(body)
		teleport_to_marker(body)
		
func teleport_to_marker(body: Node2D):
	body.global_position = $Respawn.global_position
