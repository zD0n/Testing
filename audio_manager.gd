extends Node

var active_music_stream: AudioStreamPlayer

@export_group("main")
@export var clips:  Node

func play(audio_name : String, from_position: float = 0.0 , restart: bool = false) -> void:
	if restart and active_music_stream and active_music_stream.name == audio_name:
		return
	active_music_stream = clips.get_node(audio_name)
	active_music_stream.play(from_position)
func stop() -> void:
	if active_music_stream and active_music_stream.playing:
		active_music_stream.stop()
