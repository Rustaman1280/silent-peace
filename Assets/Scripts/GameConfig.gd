extends Node

# ============================================================================
# GAME CONFIGURATION
# File ini berisi semua setting yang bisa di-tweak untuk menyesuaikan game
# ============================================================================

class_name GameConfig

# ============================================================================
# WORLD SETTINGS
# ============================================================================

# World size (in meters)
const WORLD_WIDTH: float = 200.0
const WORLD_LENGTH: float = 200.0

# Object density
const TREE_COUNT: int = 300          # Kurangi jika lag
const RABBIT_COUNT: int = 20         # Jumlah kelinci
const HILL_COUNT: int = 10           # Jumlah bukit
const GRASS_DENSITY: int = 5000      # Grass blades (kurangi jika lag)
const ROCK_COUNT: int = 50           # Akan digunakan jika ada rock models
const BUSH_COUNT: int = 100          # Akan digunakan jika ada bush models

# World generation
const USE_PROCEDURAL_HILLS: bool = true
const HILL_MAX_HEIGHT: float = 12.0
const HILL_MIN_HEIGHT: float = 5.0
const TERRAIN_NOISE_FREQUENCY: float = 0.01

# ============================================================================
# PLAYER SETTINGS
# ============================================================================

# Movement
const PLAYER_WALK_SPEED: float = 5.0
const PLAYER_SPRINT_SPEED: float = 8.0
const PLAYER_JUMP_FORCE: float = 4.5
const PLAYER_ACCELERATION: float = 10.0  # Untuk smooth movement

# Camera
const MOUSE_SENSITIVITY: float = 0.003
const CONTROLLER_SENSITIVITY: float = 3.0
const CAMERA_MIN_ANGLE: float = -89.0
const CAMERA_MAX_ANGLE: float = 89.0
const CAMERA_FOV: float = 75.0

# Player size
const PLAYER_HEIGHT: float = 1.8
const PLAYER_RADIUS: float = 0.5

# ============================================================================
# RABBIT AI SETTINGS
# ============================================================================

const RABBIT_WANDER_SPEED: float = 2.0
const RABBIT_FLEE_SPEED: float = 6.0
const RABBIT_DETECTION_RADIUS: float = 8.0  # Jarak deteksi player
const RABBIT_SAFE_DISTANCE: float = 15.0    # Jarak aman dari player
const RABBIT_WANDER_TIME_MIN: float = 2.0
const RABBIT_WANDER_TIME_MAX: float = 5.0
const RABBIT_IDLE_TIME_MIN: float = 1.0
const RABBIT_IDLE_TIME_MAX: float = 3.0
const RABBIT_IDLE_CHANCE: float = 0.3       # 30% chance untuk idle

# ============================================================================
# DAY/NIGHT CYCLE SETTINGS
# ============================================================================

const DAY_LENGTH_MINUTES: float = 10.0      # Real-time minutes
const START_TIME_OF_DAY: float = 0.3        # 0=midnight, 0.5=noon
const ENABLE_DAY_NIGHT_CYCLE: bool = true

# Time thresholds
const DAWN_START: float = 0.25
const DAWN_END: float = 0.35
const DAY_START: float = 0.35
const DAY_END: float = 0.65
const DUSK_START: float = 0.65
const DUSK_END: float = 0.75

# Lighting intensities
const NIGHT_LIGHT_INTENSITY: float = 0.1
const DAY_LIGHT_INTENSITY: float = 1.2

# ============================================================================
# VISUAL SETTINGS
# ============================================================================

# Colors
const GRASS_COLOR: Color = Color(0.2, 0.5, 0.1)
const TREE_TRUNK_COLOR: Color = Color(0.4, 0.25, 0.1)
const TREE_LEAVES_COLOR: Color = Color(0.1, 0.4, 0.1)
const RABBIT_COLOR: Color = Color(0.8, 0.75, 0.7)
const HILL_COLOR: Color = Color(0.25, 0.45, 0.15)

# Fog
const FOG_ENABLED: bool = true
const FOG_DENSITY: float = 0.001
const FOG_COLOR_DAY: Color = Color(0.517647, 0.639216, 0.690196, 1)
const FOG_COLOR_NIGHT: Color = Color(0.2, 0.25, 0.4, 1)

# Effects
const ENABLE_FIREFLIES: bool = true
const ENABLE_DUST_PARTICLES: bool = true
const ENABLE_GLOW: bool = true

# ============================================================================
# AUDIO SETTINGS
# ============================================================================

const MASTER_VOLUME: float = 0.8            # 0.0 to 1.0
const FOREST_AMBIENCE_VOLUME: float = -10.0 # in dB
const BIRD_SOUNDS_VOLUME: float = -15.0     # in dB
const WIND_VOLUME: float = -12.0            # in dB
const SFX_VOLUME: float = -8.0              # in dB

# ============================================================================
# UI SETTINGS
# ============================================================================

const SHOW_FPS: bool = true
const SHOW_CONTROLS: bool = true
const SHOW_MINIMAP: bool = true
const SHOW_CROSSHAIR: bool = true

const MINIMAP_SIZE: Vector2 = Vector2(200, 200)
const MINIMAP_ZOOM: float = 0.05

# ============================================================================
# PERFORMANCE SETTINGS
# ============================================================================

const TARGET_FPS: int = 60
const VSYNC_ENABLED: bool = true

# LOD distances (jika nanti implement LOD)
const LOD_DISTANCE_HIGH: float = 30.0
const LOD_DISTANCE_MEDIUM: float = 60.0
const LOD_DISTANCE_LOW: float = 100.0

# Shadow quality
const SHADOW_ATLAS_SIZE: int = 2048  # 4096 for high, 2048 for medium, 1024 for low
const DIRECTIONAL_SHADOW_SIZE: int = 2048

# Culling
const MAX_VISIBLE_DISTANCE: float = 150.0  # Objects beyond this aren't rendered

# ============================================================================
# DEBUG SETTINGS
# ============================================================================

const DEBUG_MODE: bool = false
const SHOW_COLLISION_SHAPES: bool = false
const PRINT_GENERATION_INFO: bool = true
const PRINT_AI_STATES: bool = false

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

static func apply_to_world_manager(world_manager: Node) -> void:
	"""Apply config to WorldManager"""
	if world_manager.has_method("set"):
		world_manager.world_size = Vector2(WORLD_WIDTH, WORLD_LENGTH)
		world_manager.tree_count = TREE_COUNT
		world_manager.rabbit_count = RABBIT_COUNT
		world_manager.hill_count = HILL_COUNT
		world_manager.grass_density = GRASS_DENSITY

static func apply_to_player(player: Node) -> void:
	"""Apply config to Player"""
	if player.has_method("set"):
		player.speed = PLAYER_WALK_SPEED
		player.sprint_speed = PLAYER_SPRINT_SPEED
		player.jump_velocity = PLAYER_JUMP_FORCE
		player.mouse_sensitivity = MOUSE_SENSITIVITY
		player.controller_sensitivity = CONTROLLER_SENSITIVITY

static func apply_to_day_night(day_night: Node) -> void:
	"""Apply config to DayNightCycle"""
	if day_night.has_method("set"):
		day_night.day_length_minutes = DAY_LENGTH_MINUTES
		day_night.start_time = START_TIME_OF_DAY

static func get_performance_preset(preset: String) -> Dictionary:
	"""Get performance preset configurations"""
	match preset:
		"low":
			return {
				"tree_count": 100,
				"rabbit_count": 10,
				"grass_density": 1000,
				"shadow_atlas": 1024,
				"enable_particles": false,
				"fog_density": 0.002
			}
		"medium":
			return {
				"tree_count": 200,
				"rabbit_count": 15,
				"grass_density": 3000,
				"shadow_atlas": 2048,
				"enable_particles": true,
				"fog_density": 0.001
			}
		"high":
			return {
				"tree_count": 300,
				"rabbit_count": 20,
				"grass_density": 5000,
				"shadow_atlas": 4096,
				"enable_particles": true,
				"fog_density": 0.001
			}
		"ultra":
			return {
				"tree_count": 500,
				"rabbit_count": 30,
				"grass_density": 10000,
				"shadow_atlas": 4096,
				"enable_particles": true,
				"fog_density": 0.0005
			}
		_:
			return get_performance_preset("medium")

static func print_current_config() -> void:
	"""Print current configuration"""
	print("\n========================================")
	print("    GAME CONFIGURATION")
	print("========================================")
	print("World Size: %.0fx%.0f meters" % [WORLD_WIDTH, WORLD_LENGTH])
	print("Trees: %d" % TREE_COUNT)
	print("Rabbits: %d" % RABBIT_COUNT)
	print("Grass Blades: %d" % GRASS_DENSITY)
	print("Day Length: %.1f minutes" % DAY_LENGTH_MINUTES)
	print("Player Speed: %.1f m/s" % PLAYER_WALK_SPEED)
	print("Sprint Speed: %.1f m/s" % PLAYER_SPRINT_SPEED)
	print("========================================\n")
