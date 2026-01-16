extends Area2D

signal on_enemy_hit

@export_range(0, 1) var slowMo: float = 0.1
@export_range(0, 360) var rot_limit: float = 70
@export var power: float = 10

@export var timer: Timer
@export var txt: Label
@export var cam: Camera2D
@export var slider: HSlider
@export var deceleration_curve: Curve
@export var force_curve: Curve

var force: float
var velocity: float
var target_velocity: float

func _ready():
    slider.min_value = - force_curve.max_domain
    slider.max_value = force_curve.max_domain

func start_slash() -> void:
    print("slash!!")
    timer.start()
    target_velocity = force
    force = 0

func get_weight() -> float:
    var t = 1 - (timer.time_left / timer.wait_time)
    return deceleration_curve.sample(t)

func compute_velocity_curve() -> void:
    var w = get_weight()
    #if !timer.is_stopped():
        #print(w)

    velocity = target_velocity * w
    rotation_degrees += velocity

func compute_velocity(delta) -> void:
    target_velocity = lerpf(target_velocity, 0, 5 * delta)
    rotation_degrees += target_velocity * delta

func slash() -> void:
    compute_velocity_curve()
    if rotation_degrees > rot_limit || rotation_degrees < -rot_limit:
        target_velocity = - target_velocity

    rotation_degrees = clampf(rotation_degrees, -rot_limit, rot_limit)

func move_sword() -> void:
    if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
        var axis: float = Input.get_axis("move_left", "move_right")
        force += axis * power
        force = clampf(force, -force_curve.max_domain, force_curve.max_domain)
        print("force: " + str(force))
    pass

    if Input.is_action_just_pressed("fire") && force != 0:
        start_slash()

func compute_damage() -> int:
    var dmg = force_curve.sample(absf(velocity))
    return roundi(dmg)

func _process(_delta: float):
    move_sword()
    slash()
    txt.text = str(roundf(rotation_degrees))
    if slider:
        slider.value = force

func attack_enemy(body: Node2D) -> void:
    var dmg = compute_damage()
    if dmg > 0:
        on_enemy_hit.emit(body)
        cam.shake()
        TimeManager.slow_motion(slowMo)
        body.takeDmg(dmg)

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("Enemies"):
        print(str(velocity) + " hit:" + str(body))
        attack_enemy(body)
