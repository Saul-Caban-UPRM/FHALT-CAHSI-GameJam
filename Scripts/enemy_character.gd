extends CharacterBody2D

@export var patrol_speed = 40
@export var chase_speed = 40
@onready var path = $"../Path2D/PathFollow2D"  # Reference to PathFollow2D set via the editor
@onready var js_cam = get_tree().current_scene.get_node("JumpScareCamera")
var patrol_offset = 0.0
var player = null
var is_chasing = false
var returning_to_patrol = false

func _ready() -> void:
	$AnimationPlayer.play("IdleLola")

func _physics_process(delta):
	if is_chasing and player:
		if player.is_hiding:
			is_chasing = false
			player = null
			returning_to_patrol = true
			return
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * chase_speed
		move_and_collide(velocity * delta)
	elif returning_to_patrol:
		# Return to path patrol
		var path_pos = path.global_position
		var direction = (path_pos - global_position).normalized()
		velocity = direction * patrol_speed
		move_and_collide(velocity * delta)
		# Check if close enough to resume patrol
		if global_position.distance_to(path_pos) < 5:
			returning_to_patrol = false
	else:
		# Normal patrol
		patrol_offset += patrol_speed * delta
		path.progress = patrol_offset
		global_position = path.global_position

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.is_hiding:
			return
		player = body
		is_chasing = true
		print("Chasing player!")

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body == player:
		if player.is_hiding:
			is_chasing = false
			print("Player hid and escaped!")
		player = null

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.reset_to_spawn()
		js_cam.start_jumpscare()
		
