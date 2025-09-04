extends Control
class_name ArrayInv

@onready var grid_i = $NinePatchRect/GridContainer
var icon_dir := "res://Image/Item_icon/"



func _ready() -> void:
	SignalBusser.connect("give_item", insert_item)
	SignalBusser.connect("kill_item", use_remove)
	generate_slot()
	load_invent()  # ← fill buttons from saved slots

func insert_item(item_n: String) -> void:
	GlobalInv.add_item(item_n)     # ← write to persistent slots
	load_invent()             # ← repaint icons

func use_remove() -> void:
	GlobalInv.remove_item()
	load_invent()

func generate_slot() -> void:
	if grid_i.get_child_count() != GlobalInv.inv_slots.size():
		for ind in range(GlobalInv.inv_slots.size()):
			var button_tx := Button.new()
			button_tx.pressed.connect(select_item.bind(ind))
			button_tx.custom_minimum_size = Vector2(160, 160)
			grid_i.add_child(button_tx)

func select_item(index: int) -> void:
	GlobalInv.current_select = GlobalInv.inv_slots[index]
	GlobalInv.current_select_index = index


func load_invent() -> void:
	for i in range(GlobalInv.inv_slots.size()):
		var but := grid_i.get_child(i)
		if but is Button:
			var name_ = GlobalInv.inv_slots[i]
			but.icon = null
			if name_ != null:
				var path_full = icon_dir + str(name_) + ".png"
				but.icon = load(path_full)
