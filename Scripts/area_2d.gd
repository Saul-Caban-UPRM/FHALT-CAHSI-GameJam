extends Node2D
var can_interact = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = false
func _process(delta):
	if can_interact and Input.is_action_just_pressed("Interact"):
		if GameState.coins_collected >= GameState.required_coins:
			GameState.AddRequiredCoins()
			GameState.SetScene("Lore2")
			MusicManager.update_music(GameState.scene)
			get_tree().change_scene_to_file("res://loor2.tscn")
