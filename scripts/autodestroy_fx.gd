extends Node2D

@export var anim: AnimatedSprite2D

func _on_animation_looped() -> void:
    queue_free()

func _process(delta):
    if Engine.time_scale < 1:
        print(anim.speed_scale)
        anim.speed_scale = Engine.time_scale * 100
    else:
        anim.speed_scale = 1
