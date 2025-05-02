extends Node2D
var coins_collected = 0
@export var required_coins = 1  # You can change this in the Inspector

func _on_coins_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("coins")
		GameState.coins_collected += 1
		$Coins.queue_free() 
