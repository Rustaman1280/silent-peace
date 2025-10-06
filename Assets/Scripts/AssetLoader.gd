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
	
	# Load forest-appropriate trees (no snow, no autumn for main forest)
	var tree_files = [
		"CommonTree_1.fbx", "CommonTree_2.fbx", "CommonTree_3.fbx", "CommonTree_4.fbx", "CommonTree_5.fbx",
		"PineTree_1.fbx", "PineTree_2.fbx", "PineTree_3.fbx", "PineTree_4.fbx", "PineTree_5.fbx",
		"BirchTree_1.fbx", "BirchTree_2.fbx", "BirchTree_3.fbx", "BirchTree_4.fbx", "BirchTree_5.fbx",
		"Willow_1.fbx", "Willow_2.fbx", "Willow_3.fbx", "Willow_4.fbx", "Willow_5.fbx"
	]
	
	for file in tree_files:
		var path = "res://Assets/Models/Trees/" + file
		if ResourceLoader.exists(path):
			var tree = load(path)
			if tree:
				trees.append(tree)
	
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

static func load_animal_models() -> Array[PackedScene]:
	var animals: Array[PackedScene] = []
	
	# Load various animal models (small to medium sized)
	var animal_files = [
		"Fox.fbx",
		"Deer.fbx", 
		"ShibaInu.fbx",
		"Husky.fbx",
		"Stag.fbx"
	]
	
	for file in animal_files:
		var path = "res://Assets/Models/Animals/" + file
		if ResourceLoader.exists(path):
			var animal = load(path)
			if animal:
				animals.append(animal)
	
	if not animals.is_empty():
		print("✅ Loaded %d animal models" % animals.size())
	else:
		print("⚠️ No animal models found")
	
	return animals

static func load_rabbit_model() -> PackedScene:
	# Try to load Deer as rabbit substitute (closest to rabbit size)
	var rabbit_path = "res://Assets/Models/Animals/Deer.fbx"
	if ResourceLoader.exists(rabbit_path):
		var rabbit = load(rabbit_path)
		if rabbit:
			print("✅ Deer model loaded (as rabbit)")
			return rabbit
	
	print("⚠️ No rabbit model loaded. Using placeholder.")
	return null

static func load_deer_model() -> PackedScene:
	var deer_path = "res://Assets/Models/Animals/Stag.fbx"
	if ResourceLoader.exists(deer_path):
		var deer = load(deer_path)
		if deer:
			print("✅ Stag model loaded")
			return deer
	return null

# ============================================================================
# PROP LOADING
# ============================================================================

static func load_rock_models() -> Array[PackedScene]:
	var rocks: Array[PackedScene] = []
	
	# Try loading from Trees folder (Rock models)
	var rock_files = [
		"Rock_1.fbx", "Rock_2.fbx", "Rock_3.fbx", "Rock_4.fbx", "Rock_5.fbx",
		"Rock_6.fbx", "Rock_7.fbx"
	]
	
	for file in rock_files:
		var path = "res://Assets/Models/Trees/" + file
		if ResourceLoader.exists(path):
			var rock = load(path)
			if rock:
				rocks.append(rock)
	
	if not rocks.is_empty():
		print("✅ Loaded %d rock models" % rocks.size())
	else:
		print("⚠️ No rock models found")
	
	return rocks

static func load_bush_models() -> Array[PackedScene]:
	var bushes: Array[PackedScene] = []
	
	# Load bush models from Props (new .gltf format)
	var bush_files = [
		"Bush.gltf", "Bush_Small.gltf", "Bush_Large.gltf",
		"Bush_Flowers.gltf", "Bush_Small_Flowers.gltf", "Bush_Large_Flowers.gltf"
	]
	
	for file in bush_files:
		var path = "res://Assets/Models/Props/" + file
		if ResourceLoader.exists(path):
			var bush = load(path)
			if bush:
				bushes.append(bush)
	
	if not bushes.is_empty():
		print("✅ Loaded %d bush models (GLTF)" % bushes.size())
	else:
		print("⚠️ No bush models found")
	
	return bushes

static func load_flower_models() -> Array[PackedScene]:
	var flowers: Array[PackedScene] = []
	
	# Load flower clump models from Props
	var flower_files = [
		"Flower_1_Clump.gltf", "Flower_2_Clump.gltf", "Flower_3_Clump.gltf",
		"Flower_4_Clump.gltf", "Flower_5_Clump.gltf"
	]
	
	for file in flower_files:
		var path = "res://Assets/Models/Props/" + file
		if ResourceLoader.exists(path):
			var flower = load(path)
			if flower:
				flowers.append(flower)
	
	if not flowers.is_empty():
		print("✅ Loaded %d flower models (GLTF)" % flowers.size())
	
	return flowers

# ============================================================================
# TEXTURE LOADING
# ============================================================================

static func load_grass_texture() -> Texture2D:
	# Load rocky terrain texture (original)
	var rocky_texture_path = "res://Assets/Textures/Terrain/rocky_terrain_02_diff_1k.png"
	if ResourceLoader.exists(rocky_texture_path):
		var texture = load(rocky_texture_path)
		if texture:
			print("✅ Rocky terrain texture loaded")
			return texture
	
	# Fallback: Try grass from Props
	var grass_texture_path = "res://Assets/Models/Props/Grass.png"
	if ResourceLoader.exists(grass_texture_path):
		var texture = load(grass_texture_path)
		if texture:
			print("✅ Grass texture loaded from Props")
			return texture
	
	print("⚠️ No terrain texture loaded. Using default color.")
	return null

static func create_terrain_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	
	# Load textures
	var albedo = load_grass_texture()
	var normal_path = "res://Assets/Textures/Terrain/rocky_terrain_02_nor_gl_1k.png"
	var roughness_path = "res://Assets/Textures/Terrain/rocky_terrain_02_rough_1k.png"
	var ao_path = "res://Assets/Textures/Terrain/rocky_terrain_02_ao_1k.png"
	
	# Apply albedo
	if albedo:
		material.albedo_texture = albedo
		material.uv1_scale = Vector3(50, 50, 1)  # Tile terrain texture
		print("✅ Terrain albedo texture applied")
	else:
		material.albedo_color = Color(0.4, 0.35, 0.3)  # Rocky brown color
		print("ℹ️ Using rocky color for terrain")
	
	# Apply normal map for detail
	if ResourceLoader.exists(normal_path):
		material.normal_enabled = true
		material.normal_texture = load(normal_path)
		material.normal_scale = 1.0
		print("✅ Normal map applied")
	
	# Apply roughness
	if ResourceLoader.exists(roughness_path):
		material.roughness_texture = load(roughness_path)
		print("✅ Roughness map applied")
	else:
		material.roughness = 0.8
	
	# Apply ambient occlusion
	if ResourceLoader.exists(ao_path):
		material.ao_enabled = true
		material.ao_texture = load(ao_path)
		material.ao_light_affect = 0.5
		print("✅ AO map applied")
	
	material.metallic = 0.0
	material.cull_mode = BaseMaterial3D.CULL_BACK
	
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
	var hdr_path = "res://Assets/Models/Sky/hay_bales_2k.hdr"
	if ResourceLoader.exists(hdr_path):
		var hdr = load(hdr_path)
		if hdr:
			print("✅ HDR skybox loaded")
			return hdr
	
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
