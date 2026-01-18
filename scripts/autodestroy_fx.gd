extends Node2D

@export var time_multiplier: float = 100
@onready var anim: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready():
    anim.animation_looped.connect(queue_free)
    anim.animation_finished.connect(queue_free)

func compensate_timeScale() -> void:
    if Engine.time_scale < 1:
        anim.speed_scale = Engine.time_scale * time_multiplier
    else:
        anim.speed_scale = 1

func _process(_delta):
    compensate_timeScale()
