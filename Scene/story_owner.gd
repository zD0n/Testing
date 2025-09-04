extends Node2D
var area_trigger_story
var coll_list = []
var event_index = 0
var select_: CollisionShape2D
var past_select: CollisionShape2D
var trigger = 0
var trig = true

func _input(event: InputEvent) -> void:
	if $Charecter_Dialog_Area.interact == true and event.is_action_pressed("Skip"):
		if trig:
			trig = false
			trigger = 1
		
		elif trigger == 7:
			$"../BlackBackground".modulate.a = 0.0
			$"../BlackBackground".visible = true
			for i in 20:
				$"../BlackBackground".modulate.a += 0.05
				await get_tree().create_timer(0.1).timeout
			trigger += 1
			
		elif trigger == 10:
			get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
			
		else:
			trigger += 1
