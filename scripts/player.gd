class_name Player
extends CharacterBody2D

const original_collider_height = 200
const original_collider_pos_height = 24
const slide_collider_pos_height = 65

#Gameplay Consts
const gravity = 48
const glide_gravity = 1
const speed = 600
const minSpeed = 300
const maxSpeed = 800
const acceleration = 1
const jump_force = -1400
const GLIDE_HOLD_THRESHOLD = 0.5
const slide_height := 120
const slide_boost = 50
const slide_duration = 0.5

var jumping = false
var gliding = false
var sliding = false
var jump_held_time = 0.0
var slide_timer = 0.0
var particle_amount = 0


var coins = 0 
#var time_running_without_obstacle

#func _init() -> void:
#	time_running_without_obstacle = get_unix_time_from_system()

func _physics_process(delta: float) -> void:

	#Update Hud
	var speed_digits = $Game_Hud/CanvasLayer/SpeedContainer/SpeedDigits
	speed_digits.set_value(int(velocity.x))
	
	if sliding:
		$AnimatedSprite2D.play("slide")
	elif !jumping and !gliding:
		if velocity.x>10:
			$AnimatedSprite2D.play("walk")
		else: 
			$AnimatedSprite2D.play("idle")
	elif jumping and !gliding:
		$AnimatedSprite2D.play("jump")
	elif gliding:
		$AnimatedSprite2D.play("glide")
		
	if is_on_floor():
		jumping = false
		gliding = false
		jump_held_time = 0.0
		
	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		gliding = false
		jump_held_time = 0.0
		print("Jump!")
		velocity.x -= 100
		velocity.y = jump_force
	
	# Handle Glide
	if jumping and not is_on_floor():
		if Input.is_action_pressed("jump"):
			jump_held_time += delta
			# Start gliding after hold threshold
			if not gliding and jump_held_time >= GLIDE_HOLD_THRESHOLD:
				gliding = true
				print("gliding")
		else:
			#On release
			gliding = false
	
	if Input.is_action_just_pressed("slide") and is_on_floor() and not sliding:
		sliding = true
		slide_timer = slide_duration
		velocity.x += slide_boost
		$CollisionShape2D.shape.size.y = slide_height
		$CollisionShape2D.position.y = slide_collider_pos_height
		
	if sliding:
		slide_timer -= delta
		if slide_timer <= 0.0 and !$RayCast2D.is_colliding():
			sliding = false
			$CollisionShape2D.shape.size.y = original_collider_height
			$CollisionShape2D.position.y = original_collider_pos_height

	# Apply gravity and acceleration
	if gliding:
		velocity.y += glide_gravity
		velocity.x -= acceleration
	else:
		velocity.y += gravity
		#Autoaccelerate Speed better to do this in visible stages
		if velocity.x < minSpeed:
			velocity.x = minSpeed
		if velocity.x < maxSpeed:
			velocity.x += acceleration
			
	#FireParticles
	#var desired_scale = clamp(int((velocity.x - 500) * 0.05), 0.0, 0.5)
	#$FireParticles.scale_amount_max = desired_scale
	#$FireParticles.scale_amount_min = desired_scale

			
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
