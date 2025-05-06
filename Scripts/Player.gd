extends CharacterBody2D

@export var speed := 40
@export var max_sprint_time := 10.0    # maximum seconds of sprint
@export var cooldown_duration := 5.0   # seconds cooldown after exhausting stamina
@export var sprint_multiplier := 1.5   # sprint speed factor
@export var slow_modifier := 0.5       # slowed factor during cooldown
@export var recharge_duration := 5.0   # seconds to fully recharge stamina when idle
@onready var joystick = $"JoystickUI/Joystick"   # Node2D parent of knob, provides posVector

# UI
@onready var stamina_bar := $CanvasLayer/StaminaBar

# hiding
var is_hiding := false
var can_hide := false

# sprint state machine
enum State { IDLE, SPRINTING, COOLDOWN }
var state := State.IDLE

var spawn_position: Vector2

# timers
var sprint_timer := max_sprint_time  # remaining stamina (seconds)
var cooldown_timer := 0.0

func _ready() -> void:
	spawn_position = global_position
	stamina_bar.max_value = max_sprint_time
	stamina_bar.min_value = 0
	stamina_bar.step = 0.1  # smooth bar
	_update_stamina_bar()

func _physics_process(delta: float) -> void:
	_handle_input(delta)
	move_and_collide(velocity * delta)

func _process(delta: float) -> void:
	_update_state(delta)
	_update_stamina_bar()

func _handle_input(delta: float) -> void:
	# read joystick first; fall back on keyboard
	var input_direction = joystick.posVector
	# clamp diagonal input to prevent >1 magnitude
	if is_hiding:
		# Only allow unhide while hiding
		if Input.is_action_just_pressed("Interact") and can_hide:
			is_hiding = false
			set_hiding_state(false)
		return  # Skip movement while hiding

	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()
	# fallback to keyboard if joystick is neutral
	if input_direction == Vector2.ZERO:
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")
		input_direction = Input.get_vector("Left", "Right", "Up", "Down")

	# footsteps
	if input_direction != Vector2.ZERO:
		if not $Footsteps.playing:
			$Footsteps.play()
	else:
		if $Footsteps.playing:
			$Footsteps.stop()

	# directional animations
	if input_direction.x < 0:
		$AnimationPlayer.play("WalkingLeft")
	elif input_direction.x > 0:
		$AnimationPlayer.play("WalkingRight")
	elif input_direction.y < 0:
		$AnimationPlayer.play("WalkingUp")
	elif input_direction.y > 0:
		$AnimationPlayer.play("WalkingDown")

	# adjust speed per state
	var current_speed = speed
	if state == State.SPRINTING:
		current_speed *= sprint_multiplier
	elif state == State.COOLDOWN:
		current_speed *= slow_modifier

	velocity = input_direction * current_speed

	# hiding toggle
	if Input.is_action_just_pressed("Interact") and can_hide:
		is_hiding = not is_hiding
		set_hiding_state(is_hiding)
		if is_hiding:
			$Footsteps.stop()
		return
func _update_state(delta: float) -> void:
	match state:
		State.IDLE:
			if Input.is_action_pressed("Sprint") and sprint_timer > 0.0:
				state = State.SPRINTING
			else:
				sprint_timer = clamp(sprint_timer + delta * (max_sprint_time / recharge_duration), 0.0, max_sprint_time)
		State.SPRINTING:
			sprint_timer = max(sprint_timer - delta, 0.0)
			if sprint_timer <= 0.0:
				state = State.COOLDOWN
				cooldown_timer = 0.0
			elif not Input.is_action_pressed("Sprint"):
				state = State.IDLE
		State.COOLDOWN:
			cooldown_timer += delta
			if cooldown_timer >= cooldown_duration:
				sprint_timer = max_sprint_time
				state = State.IDLE

func _update_stamina_bar() -> void:
	stamina_bar.value = sprint_timer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hiding_spot"):
		can_hide = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Hiding_spot"):
		can_hide = false

func set_hiding_state(hide: bool) -> void:
	$Sprite2D.visible = not hide
	$CollisionShape2D.disabled = hide
	if hide:
		velocity = Vector2.ZERO 
		$Footsteps.stop()

func reset_to_spawn() -> void:
	is_hiding = false
	can_hide = false
	global_position = spawn_position
	$Sprite2D.visible = true
	set_physics_process(true)
func HideBar():
	$CanvasLayer/StaminaBar.hide()
func ShowBar():
	$CanvasLayer/StaminaBar.show()
