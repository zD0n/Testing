extends Node2D
@onready var player: Player = $player

var delta_l = false
var trigger = 0
var trig = true


func _ready() -> void:
	$Charecter_Dialog_Area/Instant_area/CollisionShape2D.disabled = false

func _process(delta: float) -> void:
	if GlobalVal.current_state == "Floor2_Ch1":
		dialoc()
			
func dialoc() -> void:
	$"../julius/AnimatedSprite2D".play("idle_f")
	$"../julius".position = Vector2(795,450)
	#$Charecter_Dialog_Area/Instant_area/CollisionShape2D.disabled = false
	print($Charecter_Dialog_Area.area_active)
	if $Charecter_Dialog_Area.area_active and GlobalVal.current_state == "Floor2_Ch1":
		SignalBusser.emit_signal("display_char_dialog",GlobalVal.current_state)
		GlobalVal.current_state = ""
		$Charecter_Dialog_Area/Instant_area/CollisionShape2D.disabled = true
		$"../BlackBackground".visible = true
		$"../BlackBackground".modulate.a = 1.0
		delta_l = true
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Skip") and delta_l:
		if trig:
			trig = false
			trigger = 1
		
		elif trigger == 1:
			for i in 10:
				$"../BlackBackground".modulate.a -= 0.1
				await get_tree().create_timer(0.08).timeout
			trigger += 1
		
		elif trigger == 4:
			$"../julius/AnimatedSprite2D".play("walk_b")
			for i in 100:
				$"../julius".position.y -= 1.0
				await get_tree().create_timer(0.02).timeout
				
			$"../julius".visible = false
			trigger += 1
			
			
		else:
			trigger += 1

		
		
		
		
		
		
		
		
