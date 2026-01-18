extends DomeWeapon
class_name Turret

@export var _shooting: Shooting
@export var rotate_speed: float = 0.8

func _ready():
    print(owner)
    _shooting.on_bullet_shot.connect(on_bullet_shot)
    EventManager.collect_ammo.connect(ammo_from_sword)

func reset() -> void:
    pass

func ammo_from_sword(ammo_value: int, _pos: Vector2) -> void:
    print("turret get " + str(ammo_value) + " ammos !!")
    AudioManager.play_sound("ammo_earned")
    weapons.turret_ammo.add_ammo(ammo_value)

func on_bullet_shot(bullet) -> void:
    print("shoot anim!!")
    AudioManager.play_sound("jump", Vector2(0.8, 1.2))
    bullet.init(self)
    weapons.turret_ammo.shoot()

func rotate_turret(_delta: float) -> void:
    var m = Input.get_axis("move_left", "move_right")
    weapon_support.add_rot(m * rotate_speed * _delta)
    weapon_support.anchor.rotation_degrees = clamp(weapon_support.anchor.rotation_degrees, -rot_limit, rot_limit)

func _process(_delta: float):
    rotate_turret(_delta)
    if Input.is_action_pressed("fire") && weapons.turret_ammo.can_shoot:
        _shooting.shoot()
