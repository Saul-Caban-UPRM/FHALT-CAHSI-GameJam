extends CanvasLayer

func _ready() -> void:
	var somt = load("res://Levels/level1/world.tscn")
	somt = load("res://Levels/level2/Level2.tscn")
	somt = load("res://Levels/level3/Level3.tscn")
	$TextureRect/AnimationPlayer.play("Fade_in")
	
func _input(event: InputEvent) -> void:
	# Check if the "Next" action is pressed
	if event.is_action_pressed("Next"):
		if GameState.GameScene == 1:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level1/world.tscn")
		elif GameState.GameScene == 2:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level2/Level2.tscn")
		elif GameState.GameScene == 3:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level3/Level3.tscn")
		elif GameState.GameScene == 4:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.ResetGameScene()
			GameState.ResetCoinsCollected()
			get_tree().change_scene_to_file("res://Menus/FinishMenu.tscn")

	# Detecting screen taps (touch event)
	if event is InputEventScreenTouch and event.pressed:
		# Handle the scene changes for screen taps, same as the "Next" action
		if GameState.GameScene == 1:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level1/world.tscn")
		elif GameState.GameScene == 2:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level2/Level2.tscn")
		elif GameState.GameScene == 3:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.NextGameScene()
			get_tree().change_scene_to_file("res://Levels/level3/Level3.tscn")
		elif GameState.GameScene == 4:
			$TextureRect/AnimationPlayer.play("Fade_out")
			await $TextureRect/AnimationPlayer.animation_finished
			GameState.ResetGameScene()
			GameState.ResetCoinsCollected()
			get_tree().change_scene_to_file("res://Menus/FinishMenu.tscn")
