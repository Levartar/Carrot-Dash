extends Control
#@onready var optionsMenu = preload("res://options_menu.tscn")

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_pause_pressed() -> void:
	resume()

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()

func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://options_menu.tscn")
