extends Node2D

func _on_coin_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # or use `if body.is_in_group("player")`
		# You can emit a custom signal or increment coins here
		body._on_coin_entered()
		queue_free()  # Remove the coin
		#Play reomve coin sfx
