extends Area2D

var hover_amplitude := 10.0  # How far up/down it moves
var hover_speed := 0.5       # How fast it bobs
var base_position: Vector2

func _ready():
	base_position = global_position

func _process(delta: float) -> void:
	var offset = sin(Time.get_ticks_msec() / 1000.0 * hover_speed * TAU) * hover_amplitude
	global_position.y = base_position.y + offset
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body._on_damage_area_2d_body_entered(body)
		get_node("/root/Game/MoldWall").speed_wall()
