extends Node3D

# World generation settings
@export var world_size: Vector2 = Vector2(200, 200)
@export var tree_count: int = 300
@export var animal_count: int = 40  # Increased for variety
@export var hill_count: int = 10
@export var grass_density: int = 1000
@export var rock_count: int = 50
@export var bush_count: int = 80
@export var flower_count: int = 100

# Prefab references (akan diisi setelah asset dibuat)
@export var tree_prefab: PackedScene
@export var rabbit_prefab: PackedScene
@export var rock_prefab: PackedScene
@export var grass_prefab: PackedScene

# Loaded assets
var tree_models: Array[PackedScene] = []
var animal_models: Array[PackedScene] = []
var rock_models: Array[PackedScene] = []
var bush_models: Array[PackedScene] = []
var flower_models: Array[PackedScene] = []
var use_real_assets: bool = false

@onready var forest_node: Node3D = $Forest
@onready var animals_node: Node3D = $Animals
@onready var hills_node: Node3D = $Hills
@onready var terrain_node: Node3D = $Terrain

var noise: FastNoiseLite

func _ready() -> void:
	print("=== SILENT PEACE - Forest World ===")
	print("Initializing world generation...")
	
	# Check and load assets
	AssetLoader.print_asset_status()
	tree_models = AssetLoader.load_tree_models()
	animal_models = AssetLoader.load_animal_models()
	rock_models = AssetLoader.load_rock_models()
	bush_models = AssetLoader.load_bush_models()
	flower_models = AssetLoader.load_flower_models()
	use_real_assets = tree_models.size() > 0
	
	# Setup noise for terrain
	noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.frequency = 0.01
	noise.fractal_octaves = 4
	
	# Generate world
	call_deferred("generate_world")

func generate_world() -> void:
	print("Generating terrain...")
	generate_terrain()
	
	print("Generating forest...")
	generate_forest()
	
	print("Adding rocks...")
	generate_rocks()
	
	print("Adding bushes...")
	generate_bushes()
	
	print("Adding flowers...")
	generate_flowers()
	
	print("Spawning animals...")
	spawn_animals()
	
	print("Creating hills...")
	generate_hills()
	
	print("World generation complete!")

func generate_terrain() -> void:
	# Create ground plane with mesh
	var plane_mesh := PlaneMesh.new()
	plane_mesh.size = Vector2(world_size.x, world_size.y)
	plane_mesh.subdivide_width = 50
	plane_mesh.subdivide_depth = 50
	
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.mesh = plane_mesh
	
	# Create material for grass (try to load real texture or use color)
	var material = AssetLoader.create_terrain_material()
	mesh_instance.material_override = material
	
	var ground = terrain_node.get_node("Ground")
	if ground.get_node_or_null("MeshInstance3D"):
		ground.get_node("MeshInstance3D").queue_free()
	ground.add_child(mesh_instance)
	
	# Add collision
	var collision_shape := CollisionShape3D.new()
	var box_shape := BoxShape3D.new()
	box_shape.size = Vector3(world_size.x, 1, world_size.y)
	collision_shape.shape = box_shape
	collision_shape.position = Vector3(0, -0.5, 0)
	
	if ground.get_node_or_null("CollisionShape3D"):
		ground.get_node("CollisionShape3D").queue_free()
	ground.add_child(collision_shape)

func generate_forest() -> void:
	# Generate trees using placeholder meshes or real models
	print("Generating %d trees..." % tree_count)
	for i in range(tree_count):
		var tree = null
		if use_real_assets and tree_models.size() > 0:
			tree = create_real_tree()
		else:
			tree = create_placeholder_tree()
		
		var random_pos = get_random_ground_position()
		tree.position = random_pos
		forest_node.add_child(tree)
	
	if use_real_assets:
		print("✅ Forest generated with real 3D models!")
	else:
		print("⚠️ Forest generated with placeholders.")

func create_real_tree() -> StaticBody3D:
	# Use real tree models with collision
	var tree_body = StaticBody3D.new()
	
	var random_model = tree_models[randi() % tree_models.size()]
	var tree_mesh = random_model.instantiate()
	tree_mesh.rotation.y = randf() * TAU
	
	# Random scale variation
	var scale_var = randf_range(0.8, 1.2)
	tree_mesh.scale = Vector3(scale_var, scale_var, scale_var)
	
	tree_body.add_child(tree_mesh)
	
	# Add collision so player can't walk through
	var collision = CollisionShape3D.new()
	var collision_shape = CylinderShape3D.new()
	collision_shape.radius = 0.5 * scale_var  # Trunk thickness
	collision_shape.height = 8.0 * scale_var  # Tree height
	collision.shape = collision_shape
	collision.position.y = 4.0 * scale_var  # Center of cylinder
	tree_body.add_child(collision)
	
	return tree_body

func create_placeholder_tree() -> Node3D:
	var tree = Node3D.new()
	
	# Trunk
	var trunk = MeshInstance3D.new()
	var cylinder = CylinderMesh.new()
	cylinder.top_radius = 0.3
	cylinder.bottom_radius = 0.4
	cylinder.height = randf_range(4, 7)
	trunk.mesh = cylinder
	
	var trunk_mat = StandardMaterial3D.new()
	trunk_mat.albedo_color = Color(0.4, 0.25, 0.1)  # Brown
	trunk.material_override = trunk_mat
	trunk.position.y = cylinder.height / 2
	
	# Leaves (crown)
	var leaves = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = randf_range(2, 3.5)
	sphere.height = sphere.radius * 2
	leaves.mesh = sphere
	
	var leaves_mat = StandardMaterial3D.new()
	leaves_mat.albedo_color = Color(0.1, 0.4, 0.1)  # Dark green
	leaves.material_override = leaves_mat
	leaves.position.y = cylinder.height + sphere.radius * 0.5
	
	tree.add_child(trunk)
	tree.add_child(leaves)
	
	# Random rotation
	tree.rotation.y = randf() * TAU
	
	return tree

func spawn_animals() -> void:
	# Spawn various animals with real models
	if animal_models.size() > 0:
		print("Spawning %d animals with variety..." % animal_count)
		for i in range(animal_count):
			var animal = create_real_animal()
			var random_pos = get_random_ground_position()
			animal.position = random_pos
			animals_node.add_child(animal)
		print("✅ Animals spawned with real 3D models (%d types)!" % animal_models.size())
	else:
		print("⚠️ No animal models found, skipping animals.")

func create_real_animal() -> CharacterBody3D:
	var animal = CharacterBody3D.new()
	animal.add_to_group("animals")
	
	# Pick random animal model
	var random_model = animal_models[randi() % animal_models.size()]
	var mesh_instance = random_model.instantiate()
	
	# Scale down animals (they're too big by default)
	var animal_scale = randf_range(0.3, 0.5)  # Much smaller: 30-50% of original size
	mesh_instance.scale = Vector3(animal_scale, animal_scale, animal_scale)
	mesh_instance.position.y = 0  # Ground level
	mesh_instance.name = "Model"
	animal.add_child(mesh_instance)
	
	# Try to find AnimationPlayer in the model
	var anim_player = find_animation_player(mesh_instance)
	if anim_player:
		mesh_instance.set_meta("animation_player", anim_player)
		# Start with idle or walk animation if available
		if anim_player.has_animation("Walk") or anim_player.has_animation("walk"):
			var walk_anim = "Walk" if anim_player.has_animation("Walk") else "walk"
			anim_player.play(walk_anim)
		elif anim_player.has_animation("Idle") or anim_player.has_animation("idle"):
			var idle_anim = "Idle" if anim_player.has_animation("Idle") else "idle"
			anim_player.play(idle_anim)
		print("✅ Animation found for animal")
	
	# Add collision shape (scaled appropriately and solid)
	var collision = CollisionShape3D.new()
	var collision_shape = CapsuleShape3D.new()
	collision_shape.radius = 0.4 * animal_scale
	collision_shape.height = 1.2 * animal_scale
	collision.shape = collision_shape
	collision.position.y = 0.6 * animal_scale
	animal.add_child(collision)
	
	# Add AI script
	var rabbit_script = preload("res://Assets/Scripts/Rabbit.gd")
	animal.set_script(rabbit_script)
	
	# Random rotation
	animal.rotation.y = randf() * TAU
	
	return animal

func find_animation_player(node: Node) -> AnimationPlayer:
	# Recursively search for AnimationPlayer in the model
	if node is AnimationPlayer:
		return node
	for child in node.get_children():
		var result = find_animation_player(child)
		if result:
			return result
	return null

func create_placeholder_rabbit() -> CharacterBody3D:
	var rabbit_scene = preload("res://Assets/Scripts/Rabbit.gd")
	var rabbit = CharacterBody3D.new()
	rabbit.add_to_group("animals")
	
	# Body
	var body = MeshInstance3D.new()
	var box = BoxMesh.new()
	box.size = Vector3(0.4, 0.3, 0.6)
	body.mesh = box
	
	var rabbit_mat = StandardMaterial3D.new()
	rabbit_mat.albedo_color = Color(0.8, 0.75, 0.7)  # Light brown/gray
	body.material_override = rabbit_mat
	body.position.y = 0.3
	
	# Head
	var head = MeshInstance3D.new()
	var head_sphere = SphereMesh.new()
	head_sphere.radius = 0.2
	head.mesh = head_sphere
	head.material_override = rabbit_mat
	head.position = Vector3(0, 0.4, 0.35)
	
	# Collision
	var collision = CollisionShape3D.new()
	var collision_shape = CapsuleShape3D.new()
	collision_shape.radius = 0.25
	collision_shape.height = 0.5
	collision.shape = collision_shape
	collision.position.y = 0.3
	
	rabbit.add_child(body)
	rabbit.add_child(head)
	rabbit.add_child(collision)
	
	# Add AI script
	rabbit.set_script(rabbit_scene)
	
	return rabbit

func generate_hills() -> void:
	# Create hills using noise
	for i in range(hill_count):
		var hill = create_hill()
		var random_pos = get_random_ground_position()
		random_pos.y = 0
		hill.position = random_pos
		hills_node.add_child(hill)

func create_hill() -> StaticBody3D:
	# Create hill with collision
	var hill_body = StaticBody3D.new()
	
	var hill = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = randf_range(8, 15)
	sphere.height = randf_range(5, 12)
	hill.mesh = sphere
	
	# Use same terrain material as ground (with texture)
	var hill_mat = AssetLoader.create_terrain_material()
	# Make it slightly darker for variation
	if not hill_mat.albedo_texture:
		hill_mat.albedo_color = Color(0.25, 0.45, 0.15)  # Darker green if no texture
	hill.material_override = hill_mat
	
	# Scale to make it look more like a hill
	hill.scale = Vector3(1, 0.4, 1)
	# Position properly on ground (not floating)
	hill.position.y = -sphere.height * 0.15  # Adjust so bottom is at ground level
	
	hill_body.add_child(hill)
	
	# Add collision shape so player can walk on it and not go through
	var collision = CollisionShape3D.new()
	var collision_shape = SphereShape3D.new()
	collision_shape.radius = sphere.radius
	collision.shape = collision_shape
	collision.scale = Vector3(1, 0.4, 1)  # Match hill scale
	collision.position.y = -sphere.height * 0.15
	hill_body.add_child(collision)
	
	return hill_body

func generate_rocks() -> void:
	# Generate rocks scattered around the world
	if rock_models.size() > 0:
		print("Generating %d rocks with real models..." % rock_count)
		for i in range(rock_count):
			var rock_model = rock_models[randi() % rock_models.size()]
			var rock = rock_model.instantiate()
			
			var random_pos = get_random_ground_position()
			# Adjust Y position to ensure rock sits on ground
			random_pos.y = 0  # Ground level
			rock.position = random_pos
			rock.rotation.y = randf() * TAU
			# Random rotation on other axes for natural look
			rock.rotation.x = randf_range(-0.1, 0.1)
			rock.rotation.z = randf_range(-0.1, 0.1)
			
			# Random scale variation
			var scale_var = randf_range(0.5, 1.5)
			rock.scale = Vector3(scale_var, scale_var, scale_var)
			
			# Add to terrain node
			terrain_node.add_child(rock)
		print("✅ Rocks generated with real models!")
	else:
		print("⚠️ No rock models found, skipping rocks.")

func generate_bushes() -> void:
	# Generate bushes scattered around the world
	if bush_models.size() > 0:
		print("Generating %d bushes with real models..." % bush_count)
		for i in range(bush_count):
			var bush_model = bush_models[randi() % bush_models.size()]
			var bush = bush_model.instantiate()
			
			var random_pos = get_random_ground_position()
			# Ensure bush is on ground level
			random_pos.y = 0
			bush.position = random_pos
			bush.rotation.y = randf() * TAU
			
			# Random scale variation
			var scale_var = randf_range(0.7, 1.3)
			bush.scale = Vector3(scale_var, scale_var, scale_var)
			
			# Add to forest node (bushes are part of vegetation)
			forest_node.add_child(bush)
		print("✅ Bushes generated with real models!")
	else:
		print("⚠️ No bush models found, skipping bushes.")

func generate_flowers() -> void:
	# Generate flower clumps scattered around the world
	if flower_models.size() > 0:
		print("Generating %d flower clumps with real models..." % flower_count)
		for i in range(flower_count):
			var flower_model = flower_models[randi() % flower_models.size()]
			var flower = flower_model.instantiate()
			
			var random_pos = get_random_ground_position()
			# Ensure flowers are on ground level
			random_pos.y = 0
			flower.position = random_pos
			flower.rotation.y = randf() * TAU
			
			# Random scale variation (flowers should be smaller)
			var scale_var = randf_range(0.8, 1.2)
			flower.scale = Vector3(scale_var, scale_var, scale_var)
			
			# Add to forest node (flowers are part of vegetation)
			forest_node.add_child(flower)
		print("✅ Flowers generated with real models!")
	else:
		print("⚠️ No flower models found, skipping flowers.")

func get_random_ground_position() -> Vector3:
	var x = randf_range(-world_size.x / 2, world_size.x / 2)
	var z = randf_range(-world_size.y / 2, world_size.y / 2)
	# Keep Y at 0 for flat terrain (no floating objects)
	var y = 0.0
	return Vector3(x, y, z)

func get_terrain_height(x: float, z: float) -> float:
	# Use noise to get varied terrain height
	var height = noise.get_noise_2d(x, z) * 3.0
	return max(0, height)
