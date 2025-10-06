extends Control

# Minimap settings
@export var zoom: float = 0.05
@export var minimap_size: Vector2 = Vector2(200, 200)

var player: Node3D
var animals: Array = []
var trees: Array = []

@onready var minimap_panel: Panel = $MinimapPanel
@onready var canvas: Control = $MinimapPanel/Canvas

func _ready() -> void:
	# Setup minimap
	minimap_panel.size = minimap_size
	canvas.size = minimap_size

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if not player:
		player = get_tree().get_first_node_in_group("player")
		if not player:
			return
	
	# Update animals list
	if animals.is_empty():
		animals = get_tree().get_nodes_in_group("animals")
	
	var center = minimap_size / 2
	
	# Draw background circle
	draw_circle(center, minimap_size.x / 2, Color(0, 0, 0, 0.5))
	draw_arc(center, minimap_size.x / 2, 0, TAU, 32, Color(0.5, 0.5, 0.5, 0.8), 2.0)
	
	# Draw player (center)
	draw_circle(center, 5, Color(0, 1, 0, 1))
	
	# Draw player direction
	var player_forward = -player.transform.basis.z
	var dir_end = center + Vector2(player_forward.x, player_forward.z) * 15
	draw_line(center, dir_end, Color(0, 1, 0, 1), 2.0)
	
	# Draw animals (red dots)
	for animal in animals:
		if not is_instance_valid(animal):
			continue
		var relative_pos = animal.global_position - player.global_position
		var map_pos = center + Vector2(relative_pos.x, relative_pos.z) * zoom * minimap_size.x
		
		# Only draw if in minimap range
		if map_pos.distance_to(center) < minimap_size.x / 2:
			draw_circle(map_pos, 3, Color(1, 0.3, 0.3, 0.8))
