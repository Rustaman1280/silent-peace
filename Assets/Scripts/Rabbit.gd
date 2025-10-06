extends CharacterBody3D

# AI behavior settings
@export var wander_speed: float = 2.0
@export var flee_speed: float = 6.0
@export var detection_radius: float = 8.0
@export var safe_distance: float = 15.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var state: String = "wander"  # wander, flee, idle
var wander_direction: Vector3 = Vector3.ZERO
var wander_timer: float = 0.0
var idle_timer: float = 0.0
var target_rotation: float = 0.0

func _ready() -> void:
	choose_new_wander_direction()

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	
	# Check for player
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		# Determine state based on player distance
		if distance_to_player < detection_radius:
			state = "flee"
		elif distance_to_player > safe_distance and state == "flee":
			state = "wander"
	
	# Behavior based on state
	match state:
		"wander":
			handle_wander(delta)
		"flee":
			handle_flee(delta)
		"idle":
			handle_idle(delta)
	
	# Smooth rotation
	rotation.y = lerp_angle(rotation.y, target_rotation, delta * 5.0)
	
	move_and_slide()

func handle_wander(delta: float) -> void:
	wander_timer -= delta
	
	if wander_timer <= 0:
		# Chance to idle or continue wandering
		if randf() < 0.3:
			state = "idle"
			idle_timer = randf_range(1.0, 3.0)
			velocity.x = 0
			velocity.z = 0
			return
		else:
			choose_new_wander_direction()
	
	# Move in wander direction
	velocity.x = wander_direction.x * wander_speed
	velocity.z = wander_direction.z * wander_speed
	
	target_rotation = atan2(wander_direction.x, wander_direction.z)

func handle_flee(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		# Run away from player
		var flee_direction = (global_position - player.global_position).normalized()
		flee_direction.y = 0
		
		velocity.x = flee_direction.x * flee_speed
		velocity.z = flee_direction.z * flee_speed
		
		target_rotation = atan2(flee_direction.x, flee_direction.z)

func handle_idle(delta: float) -> void:
	idle_timer -= delta
	velocity.x = 0
	velocity.z = 0
	
	if idle_timer <= 0:
		state = "wander"
		choose_new_wander_direction()

func choose_new_wander_direction() -> void:
	# Random direction
	var angle = randf() * TAU
	wander_direction = Vector3(sin(angle), 0, cos(angle))
	wander_timer = randf_range(2.0, 5.0)

func _on_area_entered(area: Area3D) -> void:
	# React to player or other threats
	if area.is_in_group("player"):
		state = "flee"
