extends CharacterBody3D

# Player movement settings
@export var speed: float = 5.0
@export var sprint_speed: float = 8.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.003
@export var controller_sensitivity: float = 3.0

# Camera settings
@export var camera_min_angle: float = -89.0
@export var camera_max_angle: float = 89.0

# Head bobbing settings
@export var bob_frequency: float = 2.0
@export var bob_amplitude: float = 0.08
@export var bob_horizontal_amplitude: float = 0.05

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var camera_rotation: Vector2 = Vector2.ZERO
var bob_time: float = 0.0
var is_moving: bool = false

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D

func _ready() -> void:
	# Add to player group so animals can detect us
	add_to_group("player")
	# Capture mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	# Mouse look
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_rotation.x -= event.relative.y * mouse_sensitivity
		camera_rotation.y -= event.relative.x * mouse_sensitivity
		camera_rotation.x = clamp(camera_rotation.x, deg_to_rad(camera_min_angle), deg_to_rad(camera_max_angle))
	
	# Toggle mouse capture
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Apply camera rotation
	camera_pivot.rotation.x = camera_rotation.x
	rotation.y = camera_rotation.y
	
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get input direction
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Sprint
	var current_speed = sprint_speed if Input.is_action_pressed("sprint") else speed
	
	# Move
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
		is_moving = false
	
	move_and_slide()
	
	# Apply head bobbing
	apply_head_bob(delta, current_speed)

func apply_head_bob(delta: float, current_speed: float) -> void:
	if is_moving and is_on_floor():
		# Increase bob speed when sprinting
		var speed_multiplier = current_speed / speed
		bob_time += delta * bob_frequency * speed_multiplier
		
		# Vertical bobbing (up and down)
		var vertical_bob = sin(bob_time * 2.0) * bob_amplitude
		
		# Horizontal bobbing (side to side - slower)
		var horizontal_bob = sin(bob_time) * bob_horizontal_amplitude
		
		# Apply to camera
		camera.position.y = vertical_bob
		camera.position.x = horizontal_bob
	else:
		# Smoothly return to original position
		bob_time = 0.0
		camera.position.y = lerp(camera.position.y, 0.0, delta * 10.0)
		camera.position.x = lerp(camera.position.x, 0.0, delta * 10.0)

func _unhandled_input(event: InputEvent) -> void:
	# Debug: Print position
	if event.is_action_pressed("ui_text_completion_query"):
		print("Player position: ", global_position)
