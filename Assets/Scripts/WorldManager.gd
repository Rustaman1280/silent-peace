extends Node3D

# World generation settings
@export var world_size: Vector2 = Vector2(200, 200)
@export var tree_count: int = 300
@export var rabbit_count: int = 20
@export var hill_count: int = 10
@export var grass_density: int = 1000

# Prefab references (akan diisi setelah asset dibuat)
@export var tree_prefab: PackedScene
@export var rabbit_prefab: PackedScene
@export var rock_prefab: PackedScene
@export var grass_prefab: PackedScene

# Loaded assets
var tree_models: Array[PackedScene] = []
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

func create_real_tree() -> Node3D:
	# Use real tree models
	var random_model = tree_models[randi() % tree_models.size()]
	var tree = random_model.instantiate()
	tree.rotation.y = randf() * TAU
	# Optional: random scale variation
	var scale_var = randf_range(0.8, 1.2)
	tree.scale = Vector3(scale_var, scale_var, scale_var)
	return tree

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
	# Spawn rabbits
	for i in range(rabbit_count):
		var rabbit = create_placeholder_rabbit()
		var random_pos = get_random_ground_position()
		rabbit.position = random_pos
		animals_node.add_child(rabbit)

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

func create_hill() -> MeshInstance3D:
	var hill = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = randf_range(8, 15)
	sphere.height = randf_range(5, 12)
	hill.mesh = sphere
	
	var hill_mat = StandardMaterial3D.new()
	hill_mat.albedo_color = Color(0.25, 0.45, 0.15)  # Darker green
	hill.material_override = hill_mat
	
	# Scale to make it look more like a hill
	hill.scale = Vector3(1, 0.4, 1)
	hill.position.y = -sphere.height * 0.3
	
	return hill

func get_random_ground_position() -> Vector3:
	var x = randf_range(-world_size.x / 2, world_size.x / 2)
	var z = randf_range(-world_size.y / 2, world_size.y / 2)
	var y = get_terrain_height(x, z)
	return Vector3(x, y, z)

func get_terrain_height(x: float, z: float) -> float:
	# Use noise to get varied terrain height
	var height = noise.get_noise_2d(x, z) * 3.0
	return max(0, height)
