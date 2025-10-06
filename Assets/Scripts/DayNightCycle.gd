extends Node3D

# Day/Night cycle settings
@export var day_length_minutes: float = 10.0  # Real-time minutes for full day
@export var start_time: float = 0.3  # 0 = midnight, 0.5 = noon, 1.0 = midnight

var time_of_day: float = 0.3
var day_speed: float = 1.0

@onready var sun: DirectionalLight3D = null
@onready var environment: Environment = null

func _ready() -> void:
	time_of_day = start_time
	day_speed = 1.0 / (day_length_minutes * 60.0)
	
	# Find sun and environment
	var world = get_parent()
	if world:
		var light = world.get_node_or_null("DirectionalLight3D")
		if light:
			sun = light
		var world_env = world.get_node_or_null("WorldEnvironment")
		if world_env:
			environment = world_env.environment

func _process(delta: float) -> void:
	# Update time
	time_of_day += delta * day_speed
	if time_of_day >= 1.0:
		time_of_day -= 1.0
	
	# Update sun position and color
	if sun:
		update_sun()
	
	# Update environment
	if environment:
		update_environment()

func update_sun() -> void:
	# Sun rotation (0 = midnight, 0.5 = noon)
	var sun_angle = (time_of_day - 0.25) * TAU
	var x_rotation = sun_angle
	
	sun.rotation.x = x_rotation
	
	# Sun color and intensity based on time
	var sun_color: Color
	var sun_intensity: float
	
	if time_of_day < 0.25:  # Night
		sun_intensity = 0.1
		sun_color = Color(0.4, 0.5, 0.8)
	elif time_of_day < 0.35:  # Dawn
		var t = (time_of_day - 0.25) / 0.1
		sun_intensity = lerp(0.1, 1.0, t)
		sun_color = Color(1.0, 0.7 + t * 0.3, 0.6 + t * 0.4)
	elif time_of_day < 0.65:  # Day
		sun_intensity = 1.2
		sun_color = Color(1.0, 0.95, 0.9)
	elif time_of_day < 0.75:  # Dusk
		var t = (time_of_day - 0.65) / 0.1
		sun_intensity = lerp(1.0, 0.1, t)
		sun_color = Color(1.0, 0.7 + (1.0 - t) * 0.3, 0.5 + (1.0 - t) * 0.5)
	else:  # Night
		sun_intensity = 0.1
		sun_color = Color(0.4, 0.5, 0.8)
	
	sun.light_energy = sun_intensity
	sun.light_color = sun_color

func update_environment() -> void:
	# Update fog and ambient based on time
	if time_of_day < 0.25 or time_of_day > 0.75:  # Night
		environment.ambient_light_energy = 0.3
		environment.fog_light_color = Color(0.2, 0.25, 0.4)
	else:  # Day
		environment.ambient_light_energy = 0.5
		environment.fog_light_color = Color(0.517, 0.639, 0.690)

func get_time_string() -> String:
	var hours = int(time_of_day * 24)
	var minutes = int((time_of_day * 24 - hours) * 60)
	return "%02d:%02d" % [hours, minutes]
