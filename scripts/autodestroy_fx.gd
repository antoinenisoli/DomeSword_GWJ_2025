extends Node2D

func _on_animation_looped() -> void:
    queue_free()
