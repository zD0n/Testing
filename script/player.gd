extends CharacterBody2D
class_name Player

@onready var character := $Kyoto

@export var current_character := "chilfie"
var dialo: String = ""

var max_speed := 80.0
var acceleration := 400.0
var friction := 750.0
var last_direction := "r"  # for idle direction (f = front, b = back, r = right)
var is_playing_footstep = false
var triggered := true


func _physics_process(delta):
	var input_direction := Vector2.ZERO
	var anim := ""
	if current_character == "kyoto":
		$Kyoto.visible = true
		$Chilfie.visible = false
		character = $Kyoto
	elif current_character == "chilfie":
		$Chilfie.visible = true
		$Kyoto.visible = false
		character = $Chilfie
		
	if Input.is_action_just_pressed("p"):
		if triggered:
			current_character = "chilfie"
			triggered = false
		else:
			triggered = true
			current_character = "kyoto"

	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	elif Input.is_action_pressed("move_left"):
		input_direction.x -= 1

	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	elif Input.is_action_pressed("move_up"):
		input_direction.y -= 1

	if velocity.length() < 5:

		character.play("idle_" + last_direction)
	else:
		if abs(input_direction.x) > abs(input_direction.y):
			anim = "walk_r"
			character.flip_h = input_direction.x < 0
			last_direction = "r"
		else:
			if input_direction.y > 0:
				anim = "walk_f"
				last_direction = "f"
			elif input_direction.y < 0:
				anim = "walk_b"
				last_direction = "b"
		
		character.play(anim)
		
	input_direction = input_direction.normalized()
	if input_direction != Vector2.ZERO:
		#AudioManager.play("Footstep")
		velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
	#elif velocity == Vector2.ZERO:
		#AudioManager.stop()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	#if velocity != Vector2.ZERO:
		#if not is_playing_footstep:
			#AudioManager.play("Footstep")
			#is_playing_footstep = true
	#else:
		#if is_playing_footstep:
			#AudioManager.stop()
			#is_playing_footstep = false

	move_and_slide()
