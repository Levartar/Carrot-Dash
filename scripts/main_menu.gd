extends Control

var procedural_levels = false
var dynamic_wall = false

func _on_start_game_pressed() -> void:
	var scene = load("res://scripts/Level_select.tscn")
	get_tree().change_scene_to_packed(scene)

func _on_dynamic_wall_toggled(toggled_on: bool) -> void:
	dynamic_wall = toggled_on


func _on_procedural_levels_pressed() -> void:
	procedural_levels = !procedural_levels
	print(procedural_levels)


func _on_controls_pressed() -> void:
	var scene = load("res://controls.tscn")
	get_tree().change_scene_to_packed(scene)


func _on_credits_pressed() -> void:
	var scene = load("res://credits.tscn")
	get_tree().change_scene_to_packed(scene)
