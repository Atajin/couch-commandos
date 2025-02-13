extends Node

var gunshot_pool: Array[AudioStreamPlayer] = []
@export var gunshot_sounds: Array[AudioStream]

# Called when the node enters the scene tree.
func _ready() -> void:
	initialize_gunshot_pool()

# Initializes the gunshot audio pool.
func initialize_gunshot_pool() -> void:
	for i in range(10):
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		gunshot_pool.append(audio_player)

# Plays a gunshot sound using an available audio player.
func play_gunshot() -> void:
	for audio_player in gunshot_pool:
		if not audio_player.playing:
			audio_player.stream = gunshot_sounds.pick_random()
			audio_player.pitch_scale = randf_range(0.95, 1.05)
			audio_player.play()
			return
