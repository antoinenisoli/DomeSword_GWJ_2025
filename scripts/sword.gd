extends Area2D

@export var multiplier: int = 1
@export var max_value: int = 100
@export var rot_limit: float = 70
@export var speed: float = 70
var force: int
var target_force: int
var released: bool
var base_rot

func start_slash() -> void:
    print("start")
    target_force = force
    base_rot = rotation_degrees
    released = true

    await get_tree().create_timer(1.5).timeout
    reset()

func reset() -> void:
    print("done")
    force = 0
    released = false

func slash(delta) -> void:
    if !released:
        return
    
    rotation_degrees = lerp(rotation_degrees, base_rot + target_force, speed * delta)
    if rotation_degrees > rot_limit || rotation_degrees < -rot_limit:
        target_force = - target_force

func move_sword() -> void:
    if released:
        return

    if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
        var axis: int = Input.get_axis("move_left", "move_right") as int
        force += axis * multiplier
        force = clampi(force, -max_value, max_value)
        print(force)
    pass

    if Input.is_action_just_pressed("fire") && force != 0:
        start_slash()

func _process(delta: float):
    move_sword()
    slash(delta)
