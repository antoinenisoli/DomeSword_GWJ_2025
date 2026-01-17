extends Node2D

@export var timer: Timer

func slow_motion(value: float) -> void:
    if !timer.is_stopped():
        return

    timer.start()
    set_time(value)
    await timer.timeout
    reset_time()

func set_time(value: float) -> void:
    Engine.time_scale = value

func reset_time() -> void:
    Engine.time_scale = 1