extends Node2D
var area_trigger_story
var coll_list = []
var event_index = 0
var select_: CollisionShape2D
var past_select: CollisionShape2D
var trigger = 0
var trig = true

func _ready() -> void:
	#SignalBusser.emit_signal("display_char_dialog","Or_Ch3")
	area_trigger_story = get_children()
	activate_event()

func _process(delta: float) -> void:
	if area_trigger_story.size() > event_index:
		if area_trigger_story[event_index].area_active and area_trigger_story[event_index].interact :
			area_trigger_story[event_index].area_active = false
			recive_signal()
		
func activate_event():
	if area_trigger_story.size() > event_index:
		select_ = area_trigger_story[event_index].get_children()[1].get_children()[0]
		select_.disabled = false
		past_select = select_
		
func recive_signal():
	past_select.disabled = true
	event_index += 1
	activate_event()
