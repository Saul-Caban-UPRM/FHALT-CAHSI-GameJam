extends Node2D

func _on_coins_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("coins")
		GameState.coins_collected += 1
		$Coins.queue_free() 
