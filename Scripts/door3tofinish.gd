extends Area2D
var can_interact = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false

func _process(delta: float) -> void:
	if can_interact and Input.is_action_just_pressed("Interact"):
		if GameState.coins_collected >= GameState.required_coins:
			GameState.AddRequiredCoins()
			GameState.SetScene("Lore4")
			MusicManager.update_music(GameState.scene)
			get_tree().change_scene_to_file("res://loor4.tscn")
