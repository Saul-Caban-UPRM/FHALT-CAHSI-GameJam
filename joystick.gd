extends Node2D

var posVector: Vector2 = Vector2.ZERO

func _on_interact_pressed() -> void:
	Input.action_press("Interact")
	Input.action_release("Interact")
	
	


func _on_sprint_pressed() -> void:
	Input.action_press("Sprint")
	

func _on_sprint_released() -> void:
	Input.action_release("Sprint")
