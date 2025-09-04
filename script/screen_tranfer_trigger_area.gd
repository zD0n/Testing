extends Area2D

class_name Screen_trigger

@export var connect_scene: String #name sence
var sence_floder = "res://Scene/"
var in_area = false

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		in_area = false
		$CollisionShape2D/Press.position = $CollisionShape2D.position + Vector2(10,-32)
		$CollisionShape2D/Press.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		in_area = true
		$CollisionShape2D/Press.position = $CollisionShape2D.position + Vector2(10,-32)
		$CollisionShape2D/Press.visible = true

func _input(event: InputEvent) -> void:
	if in_area and event.is_action_pressed("interact"):
		$wrap_scene.visible = true
		for i in 11:
			$wrap_scene.modulate.a = 0.1*i
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(2).timeout
		$wrap_scene.visible = false
		SenceManager.change_screen(get_owner(), connect_scene)
	
