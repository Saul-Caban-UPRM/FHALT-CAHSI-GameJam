extends CharacterBody2D

@export var speed = 40

var is_hiding = false
var can_hide = false
var spawn_position: Vector2

func _ready() -> void:
	spawn_position = global_position

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if input_direction != Vector2.ZERO:
		if not $Footsteps.playing:
			$Footsteps.play()
	else:
		if $Footsteps.playing:
			$Footsteps.stop()

	if Input.is_action_just_pressed("Left"):
		$AnimationPlayer.play("WalkingLeft")
	elif Input.is_action_just_pressed("Right"):
		$AnimationPlayer.play("WalkingRight")

	velocity = input_direction * speed

func _physics_process(delta: float) -> void:
	get_input()	
	move_and_collide(velocity * delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hiding_spot"):
		can_hide = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Hiding_spot"):
		can_hide = false

func _process(delta):
	if Input.is_action_just_pressed("Interact") and can_hide:
		is_hiding = not is_hiding
		set_hiding_state(is_hiding)

func set_hiding_state(hide):
	$Sprite2D.visible = not hide
	$CollisionShape2D.disabled = hide
	set_physics_process(not hide)
	if hide:
		$Footsteps.stop()

func reset_to_spawn() -> void:
	is_hiding = false
	can_hide = false
	global_position = spawn_position
	$Sprite2D.visible = true
	set_physics_process(true)
