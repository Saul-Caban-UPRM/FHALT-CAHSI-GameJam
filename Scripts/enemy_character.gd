extends CharacterBody2D

@export var patrol_speed = 40
@export var chase_speed = 40
@onready var path1 = $"../Path2D/PathFollow2D"
@onready var path2 = $"../Path2/PathFollow2"
@onready var js_cam = get_tree().current_scene.get_node("JumpScareCamera")
var patrol_offset = 0.0
var player = null
var is_chasing = false
var returning_to_patrol = false
var current_path: PathFollow2D = path1
func _ready() -> void:
	$AnimationPlayer.play("IdleLola")
	if randf() < 0.5:
		current_path = path1
	else:
		current_path = path2
func _physics_process(delta):
	
	if is_chasing and player:
		if player.is_hiding:
			is_chasing = false
			player = null
			returning_to_patrol = true
			MusicManager.stop_chase_music()
			return
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * chase_speed
		move_and_collide(velocity * delta)
	elif returning_to_patrol:
		var path_pos = current_path.global_position
		var direction = (path_pos - global_position).normalized()
		velocity = direction * patrol_speed
		move_and_collide(velocity * delta)
		if global_position.distance_to(path_pos) < 5:
			var path_2d = current_path.get_parent() as Path2D
			if path_2d and path_2d.curve:
				var closest_offset = path_2d.curve.get_closest_offset(path_2d.to_local(global_position))
				patrol_offset = closest_offset
				current_path.progress = patrol_offset
				global_position = current_path.global_position
			returning_to_patrol = false
	else:
		patrol_offset += patrol_speed * delta
		current_path.progress = patrol_offset
		global_position = current_path.global_position

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !body.is_hiding:
		player = body
		is_chasing = true
		MusicManager.play_chase_music()
		print("Chasing player!")

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body == player and !player.is_hiding:
		is_chasing = false
		player = null
		
		returning_to_patrol = true
		MusicManager.stop_chase_music()

			
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.reset_to_spawn()
		MusicManager.stop_chase_music()
		js_cam.start_jumpscare()
