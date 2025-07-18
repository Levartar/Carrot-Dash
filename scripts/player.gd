class_name Player
extends CharacterBody2D

const original_collider_height = 200
const original_collider_pos_height = 24
const slide_collider_pos_height = 65

#Gameplay Consts
var gravity = 48
const glide_gravity = 1
const speed = 600
const minSpeed = 400
const maxSpeed = 775
const acceleration = 10
const jump_force = -1400
const GLIDE_HOLD_THRESHOLD = 0.5
const glide_decceleration = 3
const slide_height := 100
const slide_boost = 50
const slide_duration = 0.5
const invuln_duration = 3.0

var jumping = false
var gliding = false
var sliding = false
var damaged = false
var stop = false
var jump_held_time = 0.0
var slide_timer = 0.0
var particle_amount = 0
var invuln_timer = 0.0
var damage_timer = 0.0
var last_safe_position: Vector2

@onready var sfx_jump: AudioStreamPlayer = $sfxJump
@onready var sfx_take_damage: AudioStreamPlayer = $sfxTakeDamage

var coins = 0 
var current_level = 0
#var time_running_without_obstacle

#func _init() -> void:
#	time_running_without_obstacle = get_unix_time_from_system()
func _ready() -> void:
	resetAnims()

func resetAnims() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.reset_section()
	print("reset Anims")

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
		last_safe_position = global_position+Vector2(-250,0)
		
	# Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and !$RayCast2D.is_colliding() and !$RayCast2D.is_colliding():
		jumping = true
		gliding = false
		jump_held_time = 0.0
		print("Jump!")
		velocity.x -= 100
		velocity.y = jump_force
		sfx_jump.play()
	
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
		if slide_timer <= 0.0 and !$RayCast2D.is_colliding() and !$RayCast2D.is_colliding():
			sliding = false
			$CollisionShape2D.shape.size.y = original_collider_height
			$CollisionShape2D.position.y = original_collider_pos_height
			
	if damaged:
		invuln_timer -= delta
		damage_timer -= delta
		$AnimationPlayer.play("take_damage")
		if damage_timer > 0.0:
			$AnimatedSprite2D.play("damaged")
		if invuln_timer <= 0.0:
			damaged = false
			$AnimationPlayer.stop()

	# Apply gravity and acceleration
	if gliding:
		velocity.y += glide_gravity
		velocity.x -= glide_decceleration
		if velocity.x < minSpeed:
			velocity.x = minSpeed
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

	if !stop:
		move_and_slide()


#Loose Condition
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # or check for group, or class_name
		get_tree().reload_current_scene()

func _on_coin_entered() -> void:
	coins += 1
	var coin_digits = $Game_Hud/CanvasLayer/CoinContainer/CoinDigits
	coin_digits.set_value(coins)

#Take Damage
func _on_damage_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="Player" and !damaged:
		print("take damage")
		velocity.x = minSpeed
		damaged = true
		sfx_take_damage.play()
		invuln_timer = invuln_duration
		damage_timer = 0.5
		
func update_mask_center():
	var viewport_size = get_viewport().get_visible_rect().size
	var player_screen_pos = get_global_position()
	var center_uv = player_screen_pos / viewport_size
	$Game_Hud/CanvasLayer/ColorRect.material.set_shader_parameter("center", center_uv)

		
#Loose Condition
func loose_game(body: Node2D) -> void:
	if body.name == "Player":  # or check for group, or class_name
		var hud = body.get_child(3) #4 is hud
		hud.show_game_over()
		$AnimatedSprite2D.play("damaged")
		set_physics_process(false)



func win_game(color: String):
	stop = true
	$Game_Hud.play_outro()
	await get_tree().create_timer(2.0).timeout
	print("Win Game")
	print("Is inside tree?", is_inside_tree())
	SaveGame.save_data.saved_friends += 1
	SaveGame.save_data.completed_levels.append(current_level)
	SaveGame.save_game()
	get_tree().change_scene_to_file("res://win_screen.tscn")
	#var packed_scene  = load("res://win_screen.tscn")
	#get_tree().change_scene_to_packed(packed_scene)
