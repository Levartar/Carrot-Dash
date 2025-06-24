extends Node2D

@onready var tilemap = $TileMapLayer
@onready var tileset:TileSet = tilemap.tile_set
@onready var current_x = 12

const length = 15

func _ready():
	for i in range(length):
		var pattern = tileset.get_pattern(randi() % (tileset.get_patterns_count()-1))
		if i+1 == length:
			pattern = tileset.get_pattern(tileset.get_patterns_count()-1)
		tilemap.set_pattern(Vector2i(current_x, -16), pattern)

		var width = pattern.get_size().x
		current_x += width
