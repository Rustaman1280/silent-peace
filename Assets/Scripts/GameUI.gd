extends Control

@onready var fps_label: Label = $FPSLabel
@onready var info_label: Label = $HUD/InfoLabel

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	# Update FPS
	fps_label.text = "FPS: %d" % Engine.get_frames_per_second()

func update_info(text: String) -> void:
	info_label.text = text
