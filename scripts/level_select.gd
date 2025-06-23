extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://scripts/main_menu.tscn")
		
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/main_menu.tscn")  # Adjust path!


func _on_level_1_pressed() -> void:
	var scene = load("res://level1_flat_newTiles.tscn")
	get_tree().change_scene_to_packed(scene)
