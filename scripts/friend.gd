extends Node2D

@onready var anim_player = $AnimatedSprite2D
var colorArray: PackedStringArray = ["red","brown","yellow"]
var color="red"

func _ready() -> void:
	color = colorArray[randi()%3]
	sad_color(color)
	var win_screen = get_node("/root/WinScreen")
	var lvl_select = get_node("/root/LevelSelect")
	if win_screen||lvl_select:
		happy_color(color)  

func sad_color(color: String) -> void:
	anim_player.play("sad_"+color)
	
func happy_color(color: String) -> void:
	anim_player.play("happy_"+color)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		happy_color(color)
		body.win_game(color)
		# win game
