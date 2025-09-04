extends Node

@export var world: PackedScene
@onready var cutse_list = [$Book,$Intro1,$Intro2,$Book]
var prog = false
var curent_cutsen
var cut_dup

func _ready() -> void:
	SignalBusser.connect("cut_sence",image_change)
	SignalBusser.connect("finish_dia",change_se)
	$Character_Dialog_Layer.visible = false
	$BlackBackground.visible = true
	await get_tree().create_timer(1).timeout
	for i in 11:
		$BlackBackground.modulate.a = 1 - (0.1*i)
		await get_tree().create_timer(0.15).timeout
	await get_tree().create_timer(1.8).timeout
	$Character_Dialog_Layer.visible = true

	SignalBusser.emit_signal("display_char_dialog","Intro")
	
func image_change():
	if prog:
		curent_cutsen.hide()
		curent_cutsen = cut_dup.pop_front()
		if cut_dup.size() > 0:
			curent_cutsen.show()
			print(cut_dup.size())
		else:
			print("in")
			curent_cutsen.hide()
			prog = false

	else:
		cut_dup = cutse_list.duplicate()
		curent_cutsen = cut_dup.pop_front()
		curent_cutsen.show()
		prog = true

func change_se():
	for i in 11:
		$BlackBackground.modulate.a = 0.1*i
		await get_tree().create_timer(0.15).timeout
	await get_tree().create_timer(1).timeout
	SignalBusser.disconnect("finish_dia",change_se)
	get_tree().change_scene_to_packed(world)
