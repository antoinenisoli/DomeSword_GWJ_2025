extends Node2D

@export_range(-80, 24) var volume: float = -10
@export var list: Dictionary[String, AudioStream] = {}

func play(stream_player: AudioStreamPlayer2D) -> void:
    #print("play: " + str(stream_player))
    get_tree().current_scene.add_child(stream_player)
    stream_player.play()

func play_sound(_name: String, pitch_range: Vector2 = Vector2.ONE) -> AudioStreamPlayer2D:
    if !list.has(_name):
        assert(_name + " not found in the audio list.")
        return

    var clip: AudioStream = list.get(_name)
    if !clip:
        assert(_name + " : no clip found for this sound.")
        return

    var stream_player = AudioStreamPlayer2D.new()
    stream_player.stream = clip
    stream_player.volume_db = volume
    stream_player.pitch_scale = randf_range(pitch_range.x, pitch_range.y)
    call_deferred("play", stream_player)
    return stream_player