extends WorldEnvironment

# Environment setup with HDR skybox

func _ready() -> void:
	setup_environment()

func setup_environment() -> void:
	# Load HDR skybox
	var skybox_hdr = AssetLoader.load_skybox_hdr()
	
	if skybox_hdr:
		# Create new environment with HDR skybox
		var env = Environment.new()
		
		# Setup sky with panorama
		var sky = Sky.new()
		var sky_material = PanoramaSkyMaterial.new()
		sky_material.panorama = skybox_hdr
		sky.sky_material = sky_material
		
		env.background_mode = Environment.BG_SKY
		env.sky = sky
		env.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
		env.reflected_light_source = Environment.REFLECTION_SOURCE_SKY
		
		# Tone mapping and effects
		env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
		env.tonemap_exposure = 1.0
		
		# Glow
		env.glow_enabled = true
		env.glow_intensity = 0.8
		env.glow_strength = 1.2
		env.glow_bloom = 0.2
		
		# Fog
		env.fog_enabled = true
		env.fog_light_color = Color(0.7, 0.8, 0.9, 1)
		env.fog_density = 0.0008
		env.fog_aerial_perspective = 0.5
		env.fog_sky_affect = 0.5
		
		# SSAO for depth
		env.ssao_enabled = true
		env.ssao_radius = 1.0
		env.ssao_intensity = 2.0
		
		# Apply environment
		environment = env
		
		print("✅ HDR Skybox applied with enhanced environment!")
	else:
		print("⚠️ Using default procedural sky")
		# Keep existing procedural sky but enhance it
		if environment:
			environment.glow_enabled = true
			environment.ssao_enabled = true
