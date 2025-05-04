extends Node

var music_player: AudioStreamPlayer
var chase_music_player: AudioStreamPlayer
var current_scene = ""

var original_music_volume = -15  # in dB
var chase_music_volume = -10     # in dB
var ducked_music_volume = -30    # how quiet the background gets when chased

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.volume_db = original_music_volume
	add_child(music_player)
	
	
	chase_music_player = AudioStreamPlayer.new()
	chase_music_player.volume_db = chase_music_volume
	chase_music_player.stream = preload("res://JumpScare/audio/EnemyChasing.wav")
	
	add_child(chase_music_player)
	
	update_music(GameState.scene)
func update_music(scene_name: String):
	if scene_name == current_scene:
		return
	current_scene = scene_name

	match scene_name:
		"Level1", "Level2", "Level3":
			music_player.stream = preload("res://JumpScare/audio/BackgroundMusic.mp3")
			music_player.play()
		_:
			music_player.stop()
func play_chase_music():
	if !chase_music_player.playing:
		chase_music_player.play()
	music_player.volume_db = ducked_music_volume
func stop_chase_music():
	if chase_music_player.playing:
		chase_music_player.stop()
	music_player.volume_db = original_music_volume
