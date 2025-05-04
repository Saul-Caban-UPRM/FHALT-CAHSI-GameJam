extends Node2D


func _ready() -> void:
	GameState.SetScene("Level2")
	MusicManager.update_music(GameState.scene)
