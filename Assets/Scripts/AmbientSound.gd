extends Node

# Ambient sound settings
@export var forest_ambience_volume: float = -10.0
@export var bird_sounds_volume: float = -15.0
@export var wind_volume: float = -12.0

# Audio stream players (akan di-set setelah audio files ada)
var ambience_player: AudioStreamPlayer
var bird_player: AudioStreamPlayer
var wind_player: AudioStreamPlayer

func _ready() -> void:
	setup_audio_players()

func setup_audio_players() -> void:
	# Create audio players for ambient sounds
	ambience_player = AudioStreamPlayer.new()
	ambience_player.bus = "Master"
	ambience_player.volume_db = forest_ambience_volume
	add_child(ambience_player)
	
	bird_player = AudioStreamPlayer.new()
	bird_player.bus = "Master"
	bird_player.volume_db = bird_sounds_volume
	add_child(bird_player)
	
	wind_player = AudioStreamPlayer.new()
	wind_player.bus = "Master"
	wind_player.volume_db = wind_volume
	add_child(wind_player)
	
	# Try to load audio files
	var forest_audio = AssetLoader.load_forest_ambience()
	if forest_audio:
		ambience_player.stream = forest_audio
		ambience_player.autoplay = true
		ambience_player.play()
		print("✅ Forest ambience playing")
	
	var bird_audio = AssetLoader.load_bird_sounds()
	if bird_audio:
		bird_player.stream = bird_audio
		bird_player.autoplay = true
		bird_player.play()
		print("✅ Bird sounds playing")
	
	var wind_audio = AssetLoader.load_wind_sounds()
	if wind_audio:
		wind_player.stream = wind_audio
		wind_player.autoplay = true
		wind_player.play()
		print("✅ Wind sounds playing")
	
	if not forest_audio and not bird_audio and not wind_audio:
		print("⚠️ No audio files loaded.")
		print("   Place audio files in Assets/Audio/:")
		print("   - forest_ambience.ogg")
		print("   - birds.ogg")
		print("   - wind.ogg")
