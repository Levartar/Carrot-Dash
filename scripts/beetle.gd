extends Area2D

@onready var player = get_tree().current_scene.get_node("Player")
const move_speed := 100       # How fast it bobs
var base_position: Vector2


func _ready():
	base_position = global_position
	print(player)

func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) <= 1000:
		global_position.x -= move_speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body._on_damage_area_2d_body_entered(body)
		get_node("/root/Game/MoldWall").speed_wall()
