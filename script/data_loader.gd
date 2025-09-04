extends Node

@export var json_dir: String = "res://json_dialog/"


var json_data: Dictionary = {}

signal data_loaded

func _ready() -> void:
	load_all_json()
	data_loaded.emit()

func load_all_json() -> void:
	json_data.clear()
	var dir := DirAccess.open(json_dir)
	if dir == null:
		push_error("Directory not found: %s" % json_dir)
		return
		
	var files := dir.get_files()
	
	for file_name in files:
		if file_name.to_lower().ends_with(".json"):
			var path := json_dir.path_join(file_name)
			var file := FileAccess.open(path, FileAccess.READ)
			
			if file == null:
				push_error("Could not read file: %s" % path)
				continue
			
			var text := file.get_as_text()
			file.close()
			
			if text.is_empty():
				push_error("File is empty: %s" % path)
				continue
			
			var json := JSON.new()
			var parse_result := json.parse(text)
			
			if parse_result != OK:
				push_error("JSON parse error in %s at line %d: %s" % [path, json.get_error_line(), json.get_error_message()])
			else:
				var key := file_name.get_basename()
				json_data[key] = json.data
				print("Loaded JSON: %s" % key)

func get_json(key: String) -> Variant:
	"""Fetch JSON data by base name (filename without extension)"""
	return json_data[key]

func has_json(key: String) -> bool:
	"""Check if JSON data exists for given key"""
	return json_data.has(key)

func get_all_keys() -> Array:
	"""Get all available JSON keys"""
	return json_data.keys()
