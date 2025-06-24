extends Control



func _ready() -> void:
	SaveGame.load_game()
	var friend_count = SaveGame.save_data.saved_friends
	var friend_scene = load("res://objects/friend.tscn")
	var spawnzone = $Panel/HBoxContainer/Spawnzone2
	
	for i in range(friend_count):
		var friend_instance = friend_scene.instantiate()
		# Optionally offset their position slightly so they don't overlap
		friend_instance.scale = Vector2(0.5, 0.5)
		friend_instance.position = Vector2(50 * (i%4), 50*int(i/4))
		spawnzone.add_child(friend_instance)
	
	var children = $Panel/HBoxContainer/LevelsContainer.find_children("Star*")
	for child in children:
		var num = float(child.name.split("Star")[1])
		if num in SaveGame.save_data.completed_levels:
			child.visible = true
		else:
			child.visible = false
			

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://scripts/main_menu.tscn")
		
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/main_menu.tscn")


func _on_level_1_pressed() -> void:
	var scene = load("res://levels/level1_flat_newTiles.tscn")
	get_tree().change_scene_to_packed(scene)
