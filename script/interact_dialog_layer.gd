extends CanvasLayer

var sence_text = {}
var selected_text = []
var in_progress = false

@onready var background = $Background
@onready var label = $Label

func _ready() -> void:
	background.visible = false
	sence_text = load_text()
	SignalBusser.connect("display_dialog", on_display)
	
func load_text():
	var dict_j = DialogLoader.json_data['interact_obj_item']['content']
	return dict_j
	
func show_text():
	var pop = selected_text.pop_front()
	if pop != null:
		label.text = pop
	
func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
		
func finish():
	label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
	
func on_display(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		background.visible = true
		in_progress = true
		if text_key.split("_")[1] == "SUB":
			selected_text = sence_text["obj_sub_inter"][text_key]["line"].duplicate()
			show_text()
		elif text_key.split("_")[1] == "Main":
			selected_text = sence_text["obj_main_inter"][text_key].duplicate()
			if selected_text["need"] == GlobalInv.current_select:
				selected_text = selected_text['line'].duplicate()
				SignalBusser.emit_signal("kill_item")
				show_text()
			else:
				selected_text = selected_text['lock_line'].duplicate()
				show_text()
				
