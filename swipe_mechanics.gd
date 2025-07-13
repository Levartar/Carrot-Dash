extends Node2D

var target = 100
var startPos: Vector2
var curPos: Vector2
var swiping = false

var threshold = 30

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("press"):
		startPos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("press"):
		curPos = get_viewport().get_mouse_position()
		if startPos.distance_to(curPos) >= target:
			var swipe_vector = curPos - startPos
			var vertical_distance = swipe_vector.y
			if abs(vertical_distance) > threshold:  # Swipe threshold
				if vertical_distance < 0:
					print("Swipe Up")
					Input.action_press("jump")
					Input.action_release("slide")
				else:
					print("Swipe Down")
					Input.action_press("slide")
	if Input.is_action_just_released("press"):
		Input.action_release("jump")
		Input.action_release("slide")
