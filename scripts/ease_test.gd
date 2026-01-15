extends Node2D
@export var timer: Timer
@export var curve: float = 4.8

func _process(_delta):
    if Input.is_action_just_pressed("fire"):
        timer.start()

    var t = 1 - (timer.time_left / timer.wait_time)
    var oe = ease(t, curve)
    if !timer.is_stopped():
        print(oe)
