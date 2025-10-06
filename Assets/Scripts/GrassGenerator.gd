extends Node3D

# Grass generation settings
@export var grass_area_size: Vector2 = Vector2(200, 200)
@export var grass_density: int = 5000
@export var grass_height: float = 0.5
@export var grass_variation: float = 0.2

var multi_mesh_instance: MultiMeshInstance3D

func _ready() -> void:
	call_deferred("generate_grass")

func generate_grass() -> void:
	print("Generating grass field...")
	
	# Create MultiMesh for performance
	var multi_mesh = MultiMesh.new()
	multi_mesh.transform_format = MultiMesh.TRANSFORM_3D
	multi_mesh.instance_count = grass_density
	
	# Create grass blade mesh
	var grass_mesh = create_grass_blade_mesh()
	multi_mesh.mesh = grass_mesh
	
	# Create material
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.2, 0.6, 0.15)
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	grass_mesh.surface_set_material(0, material)
	
	# Distribute grass blades
	for i in range(grass_density):
		var transform = Transform3D()
		
		# Random position
		var x = randf_range(-grass_area_size.x / 2, grass_area_size.x / 2)
		var z = randf_range(-grass_area_size.y / 2, grass_area_size.y / 2)
		var y = 0.0  # Ground level
		
		transform.origin = Vector3(x, y, z)
		
		# Random rotation
		transform = transform.rotated(Vector3.UP, randf() * TAU)
		
		# Random scale variation
		var scale_factor = 1.0 + randf_range(-grass_variation, grass_variation)
		transform = transform.scaled(Vector3(scale_factor, scale_factor, scale_factor))
		
		multi_mesh.set_instance_transform(i, transform)
	
	# Create instance
	multi_mesh_instance = MultiMeshInstance3D.new()
	multi_mesh_instance.multimesh = multi_mesh
	multi_mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(multi_mesh_instance)
	
	print("Grass generation complete! (%d blades)" % grass_density)

func create_grass_blade_mesh() -> ArrayMesh:
	# Create a simple quad for grass blade
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	
	# Vertices
	var vertices = PackedVector3Array([
		Vector3(-0.05, 0, 0),
		Vector3(0.05, 0, 0),
		Vector3(0.05, grass_height, 0),
		Vector3(-0.05, grass_height, 0)
	])
	
	# UVs
	var uvs = PackedVector2Array([
		Vector2(0, 1),
		Vector2(1, 1),
		Vector2(1, 0),
		Vector2(0, 0)
	])
	
	# Normals
	var normals = PackedVector3Array([
		Vector3(0, 0, 1),
		Vector3(0, 0, 1),
		Vector3(0, 0, 1),
		Vector3(0, 0, 1)
	])
	
	# Indices
	var indices = PackedInt32Array([
		0, 1, 2,
		0, 2, 3
	])
	
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	
	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
	return mesh
