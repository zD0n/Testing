extends CanvasLayer

@onready var the_layer = $"."

var on_main_menu: bool = false
var on_show: bool = false

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, 0)
	

func _on_h_slider_value_changed(value: float) -> void:
	var scale = value
	
	if scale == -24:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_mute(0,false)
		AudioServer.set_bus_volume_db(0, scale)

func show_setting():
	the_layer.show()

func hide_setting():
	the_layer.hide()

func _input(event: InputEvent) -> void:
	if on_main_menu == false:
		if on_show == false and event.is_action_pressed("optional"):
			on_show = true
			the_layer.show()
		elif on_show and event.is_action_pressed("optional"):
			on_show = false
			the_layer.hide()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Sence/user_interface_layer.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_main_ma_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
