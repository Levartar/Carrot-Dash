extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#if !body.invulnerable:
			#body._on_damage_area_2d_body_entered(body)
			#teleport_to_marker(body)
			#body.loose_game(body)
			#get_node("/root/Game/MoldWall").slow_wall()
			await get_tree().create_timer(0.4).timeout
			body.loose_game(body)
			body.gravity = -12
			get_node("/root/Game/MoldWall").stop_wall()

		
func teleport_to_marker(body: Node2D):
	#body.global_position = body.last_safe_position
	var tween = get_tree().create_tween()
	tween.tween_property(body, "global_position", body.last_safe_position, 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
