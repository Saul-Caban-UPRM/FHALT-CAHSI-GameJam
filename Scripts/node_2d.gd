extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level1/world.tscn")


func _on_how_toplay_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HowToPlay.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
