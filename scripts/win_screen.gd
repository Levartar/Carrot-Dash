extends Control

@onready var friend = $VBoxContainer/Control/Friend/AnimatedSprite2D
var friendColor = "red"

func _on_back_to_level_select_pressed() -> void:
	var scene = load("res://scripts/Level_select.tscn")
	get_tree().change_scene_to_packed(scene)
	
func set_friend(color:String):
	friendColor = color
	print(friendColor)
	#friend.play("happy_"+color)
