extends CanvasLayer

func _ready() -> void:
	$AnimationPlayer.play("Fade_in")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Next") and GameState.GameScene == 1:
		
		$AnimationPlayer.play("Fade_out")
		await $AnimationPlayer.animation_finished
		GameState.NextGameScene()
		get_tree().change_scene_to_file("res://Levels/level1/world.tscn")

	elif event.is_action_pressed("Next") and GameState.GameScene == 2:
		$AnimationPlayer.play("Fade_out")
		await $AnimationPlayer.animation_finished
		GameState.NextGameScene()
		get_tree().change_scene_to_file("res://Levels/level2/Level2.tscn")
	elif event.is_action_pressed("Next") and GameState.GameScene == 3:
		$AnimationPlayer.play("Fade_out")
		await $AnimationPlayer.animation_finished
		GameState.NextGameScene()
		get_tree().change_scene_to_file("res://Levels/level3/Level3.tscn")
	elif event.is_action_pressed("Next") and GameState.GameScene == 4:
		$AnimationPlayer.play("Fade_out")
		await $AnimationPlayer.animation_finished
		GameState.ResetGameScene()
		get_tree().change_scene_to_file("res://Menus/FinishMenu.tscn")
	

		

	
	
