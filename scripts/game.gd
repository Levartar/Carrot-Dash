extends Node2D

@onready var player = $Player

func _ready():
	_on_hud_ready()
	var name = scene_file_path
	print(name)
	player.current_level = int(scene_file_path.split("level")[2].left(1))

func _on_hud_ready():
	var coin_digits = $Player/Game_Hud/CanvasLayer/CoinContainer/CoinDigits
	coin_digits.set_value(0)
	
	var speed_digits = $Player/Game_Hud/CanvasLayer/SpeedContainer/SpeedDigits
	speed_digits.set_value(10)
	
#func _process(delta):
#	$Game_Hud/CoinContainer/CoinDigits.set_value(1)
#	$Game_Hud/SpeedContainer/SpeedDigits.set_value(int(player.velocity.x))
