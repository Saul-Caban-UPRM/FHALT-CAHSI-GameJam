extends Camera2D

@onready var vp = $Control/VideoPlayer
@onready var ap = $Control/AudioStreamPlayer2D
@onready var main_cam: Camera2D = $"../Player/CharacterBody2D/Camera2D"
func start_jumpscare():

	make_current()
	
	# Pause scene AFTER camera is active
	await get_tree().process_frame  # ensure camera change takes effect
	get_tree().paused = true

	# Play jumpscare
	ap.play()
	vp.play()

	# Wait for video to finish
	await vp.finished

	# Unpause and switch back to MainCamera
	get_tree().paused = false
	main_cam.make_current()
	# Reset jumpscare
	vp.stop()
	ap.stop()
