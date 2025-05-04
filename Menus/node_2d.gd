extends Control


func _on_play_pressed() -> void:
	GameState.SetScene("Lore1")
	MusicManager.update_music(GameState.scene)
	get_tree().change_scene_to_file("res://loor.tscn")


func _on_how_toplay_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Menus/HowToPlay.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
#Level1:
#Beware there’s strange looking character 
#roaming around If I were you I stay away 
#from them if not find a hiding spot and 
#wait it out.
