extends Node2D

func _ready() -> void:
	AudioManager.play("Main")
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Intro.tscn")


func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/setting_world.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
