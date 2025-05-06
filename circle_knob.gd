extends Sprite2D

@onready var parent = $"../"
@export var maxlength := 80.0
@export var deadzone := 5.0

var pressing := false

func _ready():
	maxlength *= parent.scale.x

func _process(delta):
	
	if Input.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		if !pressing and mouse_pos.distance_to(parent.global_position) <= maxlength * 1.5:
			pressing = true

		if pressing:
			var offset = mouse_pos - parent.global_position
			var distance = offset.length()
			
			# Ensure the joystick knob doesn't go past the maximum length
			if distance <= maxlength:
				# If within the max range, set position normally
				global_position = parent.global_position + offset
			else:
				# If outside the max range, clamp to the max distance
				offset = offset.normalized() * maxlength
				global_position = parent.global_position + offset

			calculatevector()
	else:
		pressing = false
		# Smooth return to the parent position (lerp)
		global_position = lerp(global_position, parent.global_position, delta * 10)
		parent.posVector = Vector2.ZERO

func calculatevector():
	var vec = global_position - parent.global_position
	var distance = vec.length()
	if distance < deadzone:
		parent.posVector = Vector2.ZERO
	else:
		# Normalizing the vector to get the direction and scaling based on distance
		parent.posVector = vec.normalized() * min(distance / maxlength, 1.0)

func reset():
	pressing = false
	global_position = parent.global_position
	parent.posVector = Vector2.ZERO
