class_name Player
extends CharacterBody2D

const gravity = 48
const speed = 600
const minSpeed = 300
const maxSpeed = 800
const acceleration = 1
const jump_force = -1400
var jumping = false

var coins = 0 
#var time_running_without_obstacle

#func _init() -> void:
#	time_running_without_obstacle = get_unix_time_from_system()

func _physics_process(_delta: float) -> void:
	# Set Autorun autoaccelerate Speed better to do this in visible stages
	if velocity.x < minSpeed:
		velocity.x = minSpeed
	if velocity.x < maxSpeed:
		velocity.x += acceleration
	#print(velocity.x)
	
	#Update Hud
	var speed_digits = $Game_Hud/CanvasLayer/SpeedContainer/SpeedDigits
	speed_digits.set_value(int(velocity.x))
	
	
	if !jumping:
		if velocity.x>50:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		else: 
			$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("jump")
		if is_on_floor():
			jumping = false
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		print("Jump!")
		velocity.x -= 100
		velocity.y = jump_force
		
	velocity.y += gravity
	move_and_slide()


#Loose Condition
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # or check for group, or class_name
		get_tree().reload_current_scene()


func _on_coin_entered(body: Node2D) -> void:
	if body.name == "Player":  # or check for group, or class_name
		coins += 1
		var coin_digits = $Game_Hud/CanvasLayer/CoinContainer/CoinDigits
		coin_digits.set_value(coins)
