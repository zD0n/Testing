extends Area2D

@export var dialog_key = ''
var area_active = false

var once_play_bool = true
var interact = false


func _input(event: InputEvent) -> void:
	if area_active and event.is_action_pressed("interact") and dialog_key != "":
		SignalBusser.emit_signal("display_char_dialog", dialog_key)
		interact = true

func _on_area_entered(area: Area2D) -> void:
	area_active = true
	
func _on_area_exited(area: Area2D) -> void:
	area_active = false

func _on_instant_area_body_entered(body: Node2D) -> void:
	if body is Player :
		if dialog_key != "":
			SignalBusser.emit_signal("display_char_dialog", dialog_key)
		area_active = true
		#SignalBusser.emit_signal("change_event")
