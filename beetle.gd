extends Area2D

const move_speed := 100       # How fast it bobs
var base_position: Vector2

func _ready():
	base_position = global_position

func _process(delta: float) -> void:
	global_position.x -= move_speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body._on_damage_area_2d_body_entered(body)
		get_node("/root/Game/MoldWall").speed_wall()
