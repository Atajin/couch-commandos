# AudioManager.gd
extends Node

var gunshot_pool: Array[AudioStreamPlayer] = []
@export var gunshot_sounds: Array[AudioStream]

func _ready() -> void:
	for i in 10:
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		gunshot_pool.append(audio_player)

func play_gunshot() -> void:
	for audio_player in gunshot_pool:
		if !audio_player.playing:
			audio_player.stream = gunshot_sounds.pick_random()
			audio_player.pitch_scale = randf_range(0.95, 1.05)
			audio_player.play()
			break
