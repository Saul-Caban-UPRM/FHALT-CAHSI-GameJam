extends Node2D

func _ready() -> void:
	GameState.SetScene("Level1")
	MusicManager.update_music(GameState.scene)
