extends Camera2D
@onready var main_cam: Camera2D = $"../Player/CharacterBody2D/Camera2D"
@onready var minimap = get_tree().get_current_scene().get_node("Minimap")
@onready var SprintBar = $"../Player/CharacterBody2D"
var jumpscares = []

func _ready():

	$Control/JumpScareVideo1.stream = load("res://JumpScare/videos/JumpScareVideo1 - Copy.ogv")
	$Control/JumpScareVideo2.stream = load("res://JumpScare/videos/JumpScareVideo2.ogv")
	$Control/JumpScareVideo3.stream = load("res://JumpScare/videos/JumpScareVideo3.ogv")
	$Control/JumpScareVideo4.stream = load("res://JumpScare/videos/JumpScareVideo4.ogv")
	$Control/JumpScareVideo5.stream = load("res://JumpScare/videos/JumpScareVideo5.ogv")
	randomize()
	jumpscares = [
		{"video": $Control/JumpScareVideo1, "audio": $Control/JumpScare1},
		{"video": $Control/JumpScareVideo2, "audio": $Control/JumpScare2},
		{"video": $Control/JumpScareVideo3, "audio": $Control/JumpScare3},
		{"video": $Control/JumpScareVideo4, "audio": $Control/JumpScare4},
		{"video": $Control/JumpScareVideo5, "audio": $Control/JumpScare5}
	]

func start_jumpscare():

	var choice = jumpscares[randi() % jumpscares.size()]
	var vp = choice["video"]
	var ap = choice["audio"]

	if minimap:
		minimap.hide()


	make_current()
	

	await get_tree().process_frame
	get_tree().paused = true


	ap.play()
	vp.play()


	await vp.finished

	get_tree().paused = false
	main_cam.make_current()
	SprintBar.ShowBar()
	vp.stop()
	ap.stop()

	if minimap:
		minimap.show()
