extends BaseScene

func _process(delta: float) -> void:
	if $Screen_tranfer_Trigger_Area.in_area:
		$Forniture2/Door.visible = true
	elif $Screen_tranfer_Trigger_Area2.in_area:
		$Forniture2/Door.visible = true
	elif $Screen_tranfer_Trigger_Area3.in_area:
		$Forniture2/Door.visible = true
	else:
		$Forniture2/Door.visible = false
