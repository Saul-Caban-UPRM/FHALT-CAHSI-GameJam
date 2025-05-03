extends Node2D





func _on_ballora_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameState.Golden_plush = true
		$Ballora.queue_free() 
