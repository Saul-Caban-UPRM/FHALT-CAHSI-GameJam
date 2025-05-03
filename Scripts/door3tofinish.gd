extends Area2D
var can_interact = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
 

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false

func _input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("Interact"):
		if GameState.coins_collected >= GameState.required_coins:
			GameState.ResetGameScene()
			get_tree().change_scene_to_file("res://Menus/FinishMenu.tscn")
