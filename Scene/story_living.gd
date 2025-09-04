extends Node2D

var keyy = "Ch1_03"
var trigger = 0
var trig = true

func _ready() -> void:
	$"../delmon/AnimatedSprite2D".play("idle_b")
	$"../julius/AnimatedSprite2D".play("idle_b")
	$"../kyoto/AnimatedSprite2D".play("idle_f")
	$"../renbel/AnimatedSprite2D".play("idle_f")
	$"../ryou/AnimatedSprite2D".play("idle_f")
	$"../delmon".visible = true
	$"../julius".visible = true
	$"../kyoto".visible = true
	$"../renbel".visible = true
	$"../ryou".visible = true
	#$"../player".last_direction = "b"
	$"../BlackBackground".modulate.a = 0.0
	#await get_tree().create_timer(4).timeout
	#activate_sig()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Skip") and $Charecter_Dialog_Area.interact:

		if trig:
			trig = false
			trigger = 1
		
		elif trigger == 2:
			$"../kyoto/AnimatedSprite2D".play("idle_b")
			trigger += 1
			
		elif trigger == 4:
			$"../delmon/AnimatedSprite2D".play("idle_f")
			$"../julius/AnimatedSprite2D".play("idle_f")
			trigger += 1
		
		elif trigger == 14:
			for i in 10:
				$"../BlackBackground".modulate.a += 0.1
				await get_tree().create_timer(0.1).timeout
			await get_tree().create_timer(1.5).timeout
			#$"../player".last_direction = "b"
			$"../player".current_character = "chilfie"
			GlobalVal.current_state = "Floor2_Ch1"
			SenceManager.change_screen(get_owner(), "world_2")
			trigger += 1
			
		else:
			trigger += 1
