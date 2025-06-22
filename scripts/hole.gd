extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#if !body.invulnerable:
			body._on_damage_area_2d_body_entered(body)
			teleport_to_marker(body)
			get_node("/root/Game/MoldWall").slow_wall()
		
func teleport_to_marker(body: Node2D):
	#body.global_position = body.last_safe_position
	var tween = get_tree().create_tween()
	tween.tween_property(body, "global_position", body.last_safe_position, 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
