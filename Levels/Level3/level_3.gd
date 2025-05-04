extends Node2D

func _ready() -> void:
	GameState.SetScene("Level3")
	MusicManager.update_music(GameState.scene)
