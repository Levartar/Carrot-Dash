class_name Player
extends CharacterBody2D

const gravity = 48
const speed = 600
const jump_force = -1400
var jumping = false

func _physics_process(_delta: float) -> void:
	if !jumping:
		if Input.is_action_pressed("left"):
			velocity.x = -speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk")
		elif Input.is_action_pressed("right"):
			velocity.x = speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
		else: 
			velocity.x = 0
			$AnimatedSprite2D.play("idle")
	else:
		if Input.is_action_pressed("left"):
			velocity.x = -speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("jump")
		elif Input.is_action_pressed("right"):
			velocity.x = speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("jump")
		if is_on_floor():
			jumping = false
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		print("Jump!")
		velocity.y = jump_force
		
	velocity.y += gravity
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # or check for group, or class_name
		get_tree().reload_current_scene()
