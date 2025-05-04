extends Node2D

func _on_ballora_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameState.Foxy = true
		$Ballora.queue_free() 
		$Collected.play()
