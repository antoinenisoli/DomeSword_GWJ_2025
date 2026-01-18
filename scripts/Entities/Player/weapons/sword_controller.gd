extends DomeWeapon
class_name Sword

@export_range(0, 1) var slowMo: float = 0.1
@export var preview_angle: float = 10
@export var power: float = 10
@export var max_power: float = 1000
@export var push_force: float = 50

@export var charge_color: Gradient
@export var timer: Timer
@export var txt: Label
@export var force_slider: HSlider
@export var deceleration_curve: Curve
@export var force_curve: Curve

var velocity: float
var target_velocity: float
var base_rot: float

func _ready():
    reset()

func reset() -> void:
    target_velocity = 0
    force_slider.value = 0
    force_slider.value = 0
    force_slider.min_value = - max_power
    force_slider.max_value = max_power

func start_slash() -> void:
    timer.start()
    target_velocity = force_slider.value
    print("slash!! " + str(target_velocity))
    force_slider.value = 0
    charge_sword(0)

func get_weight() -> float:
    var t = 1 - (timer.time_left / timer.wait_time)
    return deceleration_curve.sample(t)

func compute_velocity_curve(delta) -> void:
    var w = get_weight()
    #if !timer.is_stopped():
        #print(w)

    velocity = (target_velocity * w) * delta
    #print(velocity)
    weapon_support.add_rot(velocity)

func hit_bound() -> void:
    AudioManager.play_sound("enemy_death", Vector2(1.5, 4))
    target_velocity *= -1

    #keep rotation in limits
    var i = sign(weapon_support.anchor.global_rotation_degrees)
    weapon_support.anchor.global_rotation_degrees = rot_limit * i
    print(weapon_support.anchor.global_rotation_degrees)

func slash(delta) -> void:
    compute_velocity_curve(delta)
    if weapon_support.anchor.global_rotation_degrees > rot_limit || weapon_support.anchor.global_rotation_degrees < -rot_limit:
        hit_bound()

func charge_sword(axis: float) -> void:
    weapon_support.add_rot(-axis * preview_angle)
    var v = absf(force_slider.value) / max_power
    print(v)
    for spr in weapon_support.sword_sprites:
        spr.self_modulate = charge_color.sample(v)

func move_sword() -> void:
    if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
        var axis: float = Input.get_axis("move_left", "move_right")
        force_slider.value += axis * power
        if target_velocity == 0 && force_slider.value < force_slider.max_value && force_slider.value > force_slider.min_value:
            charge_sword(axis)

        #weapon_support.add_rot(axis * power)
        #print("force: " + str(force_slider.value))
    pass

    if Input.is_action_just_pressed("fire") && force_slider.value != 0:
        start_slash()

func compute_damage() -> int:
    var dmg = force_curve.sample(absf(velocity))
    return roundi(dmg)

func _process(_delta: float):
    move_sword()
    slash(_delta)
    txt.text = str(roundf(weapon_support.anchor.global_rotation_degrees))

func play_vfx(body) -> void:
    var fx = FxManager.spawn_fx("blood_stream", body.position)
    fx.anim.flip_h = target_velocity > 0

func attack_enemy(enemy: Enemy) -> void:
    var dmg = compute_damage()
    print(str(velocity) + " converted to damages: " + str(dmg))
    if dmg <= 0:
        return

    TimeManager.slow_motion(slowMo)
    play_vfx(enemy)
    EventManager.on_sword_hit.emit(dmg)

    enemy.takeDmg(dmg)
    enemy.get_parent().push_back(absf(velocity) * push_force)
    if collect_enabled && enemy.ammo_value > 0 && enemy.health_value() == 0: # the enemy has been killed
        EventManager.collect_ammo.emit(enemy.ammo_value, enemy.global_position)
        pass

func _on_body_entered(body: Node2D) -> void:
    if !body.is_in_group("Enemies"):
        return

    if can_hit(body.enemy):
        #print(str(velocity) + " hit:" + str(body))
        attack_enemy(body.enemy)

func _on_swing_timer_timeout() -> void:
    reset()
    base_rot = weapon_support.anchor.global_rotation_degrees
