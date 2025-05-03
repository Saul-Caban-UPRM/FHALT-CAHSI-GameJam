extends Camera2D

@onready var vp = $Control/VideoPlayer
@onready var ap = $Control/AudioStreamPlayer2D
@onready var main_cam: Camera2D = $"../Player/CharacterBody2D/Camera2D"
@onready var minimap   = get_tree().get_current_scene().get_node("Minimap")  

func start_jumpscare():
	if minimap:
		minimap.hide()
	make_current()
	
	# Pause scene AFTER camera is active
	await get_tree().process_frame  # ensure camera change takes effect
	get_tree().paused = true

	# Play jumpscare
	ap.play()
	vp.play()
	if minimap:
		minimap.visible = false
	# Wait for video to finish
	await vp.finished

	# Unpause and switch back to MainCamera
	get_tree().paused = false
	main_cam.make_current()
	# Reset jumpscare
	vp.stop()
	ap.stop()
	if minimap:
		minimap.visible = true
