extends Node2D

var distance = 100
var startPos: Vector2
var curPos: Vector2
var start_time: float
var threshold := 30
var max_tap_duration := 0.2


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("press"):
		startPos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("press"):
		curPos = get_viewport().get_mouse_position()
		if startPos.distance_to(curPos) >= distance:
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
		
#func _process(delta: float) -> void:
#	if Input.is_action_just_pressed("press"):
#		startPos = get_viewport().get_mouse_position()
#		start_time = Time.get_ticks_msec() / 1000.0
#	if Input.is_action_pressed("press"):
#		curPos = get_viewport().get_mouse_position()
#		if startPos.distance_to(curPos) >= distance:
#			var swipe_vector = curPos - startPos
#			var horizontal_distance = swipe_vector.x
#			if abs(horizontal_distance) > threshold:  # Swipe threshold
#				if horizontal_distance < 0:
#					print("Swipe Right")
#					Input.action_press("slide")
#					#Input.action_release("slide")
#				else:
#					print("Swipe Left")
#					#Input.action_press("slide")
#	if Input.is_action_just_released("press"):
#		var duration = (Time.get_ticks_msec() / 1000.0) - start_time
#		if distance < threshold and duration < max_tap_duration:
#			print("Tap detected")
#			Input.action_press("jump")
#		else:
#			Input.action_release("jump")
#			Input.action_release("slide")
#
