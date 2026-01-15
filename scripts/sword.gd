extends Area2D

@export var power: float = 1
@export var min_value: float = 1
@export var max_value: float = 100
@export var rot_limit: float = 70
@export var speed: float = 70

@export var txt: Label
@export var timer: Timer

var force: float
var velocity: float

func start_slash() -> void:
    print("start")
    velocity = force
    force = 0

func slash(delta) -> void:
    velocity = lerpf(velocity, 0, speed * delta)
    rotation_degrees += velocity * delta
    if rotation_degrees > rot_limit || rotation_degrees < -rot_limit:
        velocity = - velocity

    rotation_degrees = clampf(rotation_degrees, -rot_limit, rot_limit)

func move_sword() -> void:
    if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
        var axis: float = Input.get_axis("move_left", "move_right")
        force += axis * power
        force = clampf(force, -max_value, max_value)
        print(force)
    pass

    if Input.is_action_just_pressed("fire") && force != 0:
        start_slash()

func _process(delta: float):
    move_sword()
    slash(delta)
    txt.text = str(roundf(rotation_degrees))

func check_velocity() -> bool:
    return absf(velocity) >= min_value

func get_damage() -> int:
    return absi(roundi(velocity))

func slow_motion() -> void:
    timer.start()
    Engine.time_scale = 0.1
    await timer.timeout
    Engine.time_scale = 1

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Enemies"):
        print(str(velocity) + " hit:" + str(body))
        if check_velocity():
            slow_motion()
            body.takeDmg(get_damage())
