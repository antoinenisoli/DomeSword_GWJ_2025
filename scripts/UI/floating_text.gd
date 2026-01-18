extends Node2D

@export var txt: RichTextLabel
@export var up_offset: Vector2
@export var tween_duration: float

func _ready():
    call_deferred("play_tween")

func play_tween() -> void:
    var tween := create_tween().set_parallel(true)
    tween.tween_property(self, "position", global_position + up_offset, tween_duration)
    var c = Color.WHITE
    c.a = 0
    tween.tween_property(txt, "theme_override_colors/default_color", c, tween_duration)
    tween.play()
    
    await tween.finished
    queue_free()

func set_text(content: String) -> void:
    txt.text = "+" + content + " ammo"
