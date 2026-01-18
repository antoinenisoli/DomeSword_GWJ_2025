extends Node2D

@export var txt: RichTextLabel
@export var up_offset: Vector2
@export var tween_duration: float

func _ready():
    call_deferred("play_tween")

func play_tween() -> void:
    var tween := create_tween()
    tween.tween_property(self, "position", global_position + up_offset, tween_duration)
    #tween.tween_property(txt, "color.a", 0, tween_duration)
    tween.play()
    await tween.finished
    queue_free()

func set_text(content: String) -> void:
    txt.text = "+" + content
