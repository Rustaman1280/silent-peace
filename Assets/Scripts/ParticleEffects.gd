extends Node3D

# Particle effects for atmosphere (fireflies, dust, etc)

func _ready() -> void:
	create_fireflies()
	create_dust_particles()

func create_fireflies() -> void:
	var particles = GPUParticles3D.new()
	particles.amount = 50
	particles.lifetime = 5.0
	particles.explosiveness = 0.0
	particles.randomness = 0.5
	particles.visibility_aabb = AABB(Vector3(-100, 0, -100), Vector3(200, 50, 200))
	particles.emitting = true
	
	# Process material
	var process_mat = ParticleProcessMaterial.new()
	process_mat.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	process_mat.emission_box_extents = Vector3(100, 5, 100)
	process_mat.direction = Vector3(0, 0.5, 0)
	process_mat.spread = 45.0
	process_mat.initial_velocity_min = 0.5
	process_mat.initial_velocity_max = 1.5
	process_mat.gravity = Vector3(0, 0.1, 0)
	process_mat.scale_min = 0.1
	process_mat.scale_max = 0.3
	
	# Color
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1, 1, 0.5, 0))
	gradient.add_point(0.5, Color(1, 1, 0.5, 1))
	gradient.add_point(1.0, Color(1, 1, 0.5, 0))
	var gradient_texture = GradientTexture1D.new()
	gradient_texture.gradient = gradient
	process_mat.color_ramp = gradient_texture
	
	particles.process_material = process_mat
	
	# Draw pass mesh
	var sphere = SphereMesh.new()
	sphere.radial_segments = 8
	sphere.rings = 4
	sphere.radius = 0.1
	particles.draw_pass_1 = sphere
	
	add_child(particles)
	print("Fireflies particles created")

func create_dust_particles() -> void:
	var particles = GPUParticles3D.new()
	particles.amount = 100
	particles.lifetime = 8.0
	particles.explosiveness = 0.0
	particles.randomness = 0.8
	particles.visibility_aabb = AABB(Vector3(-50, 0, -50), Vector3(100, 30, 100))
	particles.emitting = true
	
	# Process material
	var process_mat = ParticleProcessMaterial.new()
	process_mat.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	process_mat.emission_box_extents = Vector3(50, 1, 50)
	process_mat.direction = Vector3(1, 1, 0)
	process_mat.spread = 180.0
	process_mat.initial_velocity_min = 0.1
	process_mat.initial_velocity_max = 0.5
	process_mat.gravity = Vector3(0, 0.05, 0)
	process_mat.scale_min = 0.05
	process_mat.scale_max = 0.15
	
	# Color - subtle white dust
	process_mat.color = Color(1, 1, 1, 0.3)
	
	particles.process_material = process_mat
	
	# Draw pass mesh
	var sphere = SphereMesh.new()
	sphere.radial_segments = 4
	sphere.rings = 2
	sphere.radius = 0.05
	particles.draw_pass_1 = sphere
	
	add_child(particles)
	print("Dust particles created")
