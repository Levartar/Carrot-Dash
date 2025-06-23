extends Control

@onready var panel: Panel = $CanvasLayer/Panel
@onready var canvas: CanvasLayer = $CanvasLayer
@onready var root_scene = get_tree().current_scene

func _ready():
	panel.modulate.a = 0.0
	play_intro()

func show_game_over():
	panel.visible = true
	panel.modulate.a = 0.0
	
	play_outro()
	await get_tree().create_timer(2.0).timeout

	var tween = get_tree().create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 1.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
func play_intro():
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/ColorRect.material, "shader_parameter/radius", 1.5, 5.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func play_outro():
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/ColorRect.material, "shader_parameter/radius", 0.0, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/main_menu.tscn")
