extends Control

func _ready() -> void:
	SaveGame.load_game()
	$HBoxContainer/VBoxContainer3/ProceduralLevels.button_pressed = SaveGame.save_data.config.procedural
	$HBoxContainer/VBoxContainer4/DynamicWall.button_pressed = SaveGame.save_data.config.wall_dynamic

func _on_start_game_pressed() -> void:
	var scene = load("res://scripts/Level_select.tscn")
	if SaveGame.save_data.config.procedural:
		scene = load("res://levels/procedural_level.tscn")
	SaveGame.save_data
	get_tree().change_scene_to_packed(scene)

func _on_dynamic_wall_toggled(toggled_on: bool) -> void:
	SaveGame.save_data.config.wall_dynamic=toggled_on

func _on_controls_pressed() -> void:
	var scene = load("res://controls.tscn")
	get_tree().change_scene_to_packed(scene)


func _on_credits_pressed() -> void:
	var scene = load("res://credits.tscn")
	get_tree().change_scene_to_packed(scene)


func _on_procedural_levels_toggled(toggled_on: bool) -> void:
	SaveGame.save_data.config.procedural=toggled_on
