extends Node

# ASSET INTEGRATION HELPER
# File ini berisi fungsi-fungsi helper untuk mengintegrasikan asset real
# Uncomment dan gunakan setelah Anda punya asset 3D yang sebenarnya

class_name AssetLoader

# ============================================================================
# TREE LOADING
# ============================================================================

static func load_tree_models() -> Array[PackedScene]:
	var trees: Array[PackedScene] = []
	
	# Method 1: Load individual files
	# Uncomment setelah Anda punya file tree models
	
	# var pine_1 = load("res://Assets/Models/Trees/pine_tree_01.glb")
	# if pine_1:
	# 	trees.append(pine_1)
	
	# var oak_1 = load("res://Assets/Models/Trees/oak_tree_01.glb")
	# if oak_1:
	# 	trees.append(oak_1)
	
	# Method 2: Auto-load all .glb files from folder
	# trees = auto_load_models_from_folder("res://Assets/Models/Trees/")
	
	if trees.is_empty():
		print("⚠️ No tree models loaded. Using placeholders.")
	else:
		print("✅ Loaded %d tree models" % trees.size())
	
	return trees

static func auto_load_models_from_folder(folder_path: String) -> Array[PackedScene]:
	var models: Array[PackedScene] = []
	var dir = DirAccess.open(folder_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and (file_name.ends_with(".glb") or file_name.ends_with(".fbx")):
				var full_path = folder_path + file_name
				var model = load(full_path)
				if model:
					models.append(model)
					print("  - Loaded: %s" % file_name)
			file_name = dir.get_next()
		
		dir.list_dir_end()
	
	return models

# ============================================================================
# ANIMAL LOADING
# ============================================================================

static func load_rabbit_model() -> PackedScene:
	# Uncomment setelah punya rabbit model
	# var rabbit = load("res://Assets/Models/Animals/rabbit.glb")
	# if rabbit:
	# 	print("✅ Rabbit model loaded")
	# 	return rabbit
	
	print("⚠️ No rabbit model loaded. Using placeholder.")
	return null

static func load_deer_model() -> PackedScene:
	# var deer = load("res://Assets/Models/Animals/deer.glb")
	# if deer:
	# 	return deer
	return null

# ============================================================================
# PROP LOADING
# ============================================================================

static func load_rock_models() -> Array[PackedScene]:
	var rocks: Array[PackedScene] = []
	# rocks = auto_load_models_from_folder("res://Assets/Models/Props/Rocks/")
	return rocks

static func load_bush_models() -> Array[PackedScene]:
	var bushes: Array[PackedScene] = []
	# bushes = auto_load_models_from_folder("res://Assets/Models/Props/Bushes/")
	return bushes

# ============================================================================
# TEXTURE LOADING
# ============================================================================

static func load_grass_texture() -> Texture2D:
	# Uncomment setelah punya grass texture
	# var texture = load("res://Assets/Textures/Terrain/grass_albedo.png")
	# if texture:
	# 	print("✅ Grass texture loaded")
	# 	return texture
	
	print("⚠️ No grass texture loaded. Using default color.")
	return null

static func create_terrain_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	
	# Load textures
	var albedo = load_grass_texture()
	# var normal = load("res://Assets/Textures/Terrain/grass_normal.png")
	# var roughness = load("res://Assets/Textures/Terrain/grass_roughness.png")
	
	if albedo:
		material.albedo_texture = albedo
	else:
		material.albedo_color = Color(0.2, 0.5, 0.1)  # Fallback to green
	
	# if normal:
	# 	material.normal_enabled = true
	# 	material.normal_texture = normal
	
	# if roughness:
	# 	material.roughness_texture = roughness
	
	material.roughness = 0.9
	material.uv1_scale = Vector3(10, 10, 1)  # Tile texture
	
	return material

# ============================================================================
# AUDIO LOADING
# ============================================================================

static func load_forest_ambience() -> AudioStream:
	# var audio = load("res://Assets/Audio/forest_ambience.ogg")
	# if audio:
	# 	print("✅ Forest ambience loaded")
	# 	return audio
	
	print("⚠️ No forest ambience loaded.")
	return null

static func load_bird_sounds() -> AudioStream:
	# var audio = load("res://Assets/Audio/birds.ogg")
	# if audio:
	# 	return audio
	return null

static func load_wind_sounds() -> AudioStream:
	# var audio = load("res://Assets/Audio/wind.ogg")
	# if audio:
	# 	return audio
	return null

# ============================================================================
# SKYBOX LOADING
# ============================================================================

static func load_skybox_hdr() -> Texture:
	# var hdr = load("res://Assets/Textures/Sky/forest_skybox.hdr")
	# if hdr:
	# 	print("✅ HDR skybox loaded")
	# 	return hdr
	
	print("⚠️ No skybox loaded. Using procedural sky.")
	return null

static func create_skybox_environment() -> Environment:
	var env = Environment.new()
	
	var skybox = load_skybox_hdr()
	if skybox:
		var sky = Sky.new()
		var sky_material = PanoramaSkyMaterial.new()
		sky_material.panorama = skybox
		sky.sky_material = sky_material
		env.background_mode = Environment.BG_SKY
		env.sky = sky
	else:
		# Use procedural sky
		env.background_mode = Environment.BG_SKY
		var sky = Sky.new()
		var proc_sky = ProceduralSkyMaterial.new()
		proc_sky.sky_horizon_color = Color(0.64625, 0.65575, 0.67075, 1)
		proc_sky.ground_horizon_color = Color(0.64625, 0.65575, 0.67075, 1)
		sky.sky_material = proc_sky
		env.sky = sky
	
	# Common environment settings
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.glow_enabled = true
	env.fog_enabled = true
	env.fog_light_color = Color(0.517647, 0.639216, 0.690196, 1)
	env.fog_density = 0.001
	
	return env

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

static func check_asset_availability() -> Dictionary:
	"""Check which assets are available"""
	var status = {
		"trees": false,
		"rabbit": false,
		"props": false,
		"textures": false,
		"audio": false,
		"skybox": false
	}
	
	# Check trees
	if DirAccess.dir_exists_absolute("res://Assets/Models/Trees/"):
		var trees = auto_load_models_from_folder("res://Assets/Models/Trees/")
		status["trees"] = trees.size() > 0
	
	# Check rabbit
	if ResourceLoader.exists("res://Assets/Models/Animals/rabbit.glb"):
		status["rabbit"] = true
	
	# Check textures
	if ResourceLoader.exists("res://Assets/Textures/Terrain/grass_albedo.png"):
		status["textures"] = true
	
	# Check audio
	if ResourceLoader.exists("res://Assets/Audio/forest_ambience.ogg"):
		status["audio"] = true
	
	# Check skybox
	if ResourceLoader.exists("res://Assets/Textures/Sky/forest_skybox.hdr"):
		status["skybox"] = true
	
	return status

static func print_asset_status() -> void:
	print("\n========================================")
	print("    ASSET AVAILABILITY STATUS")
	print("========================================")
	
	var status = check_asset_availability()
	
	for key in status.keys():
		var icon = "✅" if status[key] else "❌"
		var text = key.capitalize()
		print("%s %s" % [icon, text])
	
	print("========================================\n")
	
	# Count available
	var available_count = 0
	for value in status.values():
		if value:
			available_count += 1
	
	if available_count == 0:
		print("📦 No custom assets loaded. Using ALL placeholders.")
		print("   See ASSETS_NEEDED.md for download links.")
	elif available_count == status.size():
		print("🎉 All custom assets loaded! Game is fully HD.")
	else:
		print("⚙️ Using mix of custom assets and placeholders.")
		print("   Add more assets to improve visuals!")
	
	print("")

# ============================================================================
# EXAMPLE USAGE
# ============================================================================

# Cara pakai di WorldManager.gd:
#
# func _ready():
#     AssetLoader.print_asset_status()
#     
#     var trees = AssetLoader.load_tree_models()
#     if trees.size() > 0:
#         use_real_trees(trees)
#     else:
#         use_placeholder_trees()
