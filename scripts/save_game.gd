extends Node

# Save file path (user:// resolves to OS-specific save folder)
const SAVE_PATH := "res://savegame.json"

var save_data: Dictionary = {
	"config": {
		"procedural":false,
		"wall_dynamic": true,
	},
	"completed_levels": [],
	"saved_friends": 0
}

func reset_save():
	save_game()
	load_game()

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found.")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if result is Dictionary:
		save_data = result
		print("Loaded save:", save_data)
