extends Node

var inv_slots: Array = [null, null, null, null, null]
var current_select = ""
var current_select_index = -1

func add_item(name: String) -> void:
	if name in inv_slots:
		return
	else:
		for i in range(inv_slots.size()):
			if inv_slots[i] == null:
				inv_slots[i] = name
				return

func remove_item() -> void:
	inv_slots[current_select_index] = null
	return
