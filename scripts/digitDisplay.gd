extends Control

@export var digit_scene: PackedScene         # A preconfigured digit node (Sprite2D or AnimatedSprite2D)
@export var max_digits := 3
@export var frames: SpriteFrames             # Set to your digits_frames.tres

const digit_width = 128
const digit_height= 128

var digits := []

func _ready():
	# Create digit sprites
	digits = get_children()
	
	for digit in digits:
		if digit is AnimatedSprite2D:
			digit.sprite_frames = frames
			digit.animation = "digits"

	set_value(0)

func set_value(value: int):
	var str_value = "%0*d" % [max_digits, value]
	for i in max_digits:
		var char = str_value[i]
		var num = int(char)
		if i < digits.size():
			var digit = digits[i]
			if digit is AnimatedSprite2D:
				digit.frame = num
			elif digit is Sprite2D:
				digit.region_rect = Rect2(num * digit_width, 0, digit_width, digit_height)
