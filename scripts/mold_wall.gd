extends Node2D

@onready var sfx_mold_wall: AudioStreamPlayer2D = $sfxMoldWall

@onready var player:Player = get_node("/root/Game/Player")
@onready var dynamic_wall = SaveGame.save_data.config.wall_dynamic
var speed = 700
var current_speed = speed



func _ready() -> void:
	sfx_mold_wall.play()
	if !dynamic_wall:
		speed = 750

func _process(delta):
	#Mold doesnt fall back
	if !player.stop:
		var pos = player.position.x-1000
		if pos>position.x && dynamic_wall:
			position.x = pos
		else:
			position.x += current_speed * delta
	else:
		$Particles.toggle_particles()
	
func speed_wall():
	print("wallboost")
	if dynamic_wall:
		current_speed = speed+300
		await get_tree().create_timer(2.0).timeout
		current_speed = speed
	
func slow_wall():
	if dynamic_wall:
		current_speed = 200      
		await get_tree().create_timer(2.0).timeout
		current_speed = speed

func stop_wall():
	if dynamic_wall:
		current_speed = 0      

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.loose_game(body)
		print("moldloose")
		sfx_mold_wall.stop()
