extends Node2D
class_name WeaponInventory

@export var switch_cooldown: Timer
@export var turret_ammo: AmmoContainer
@export var weapons: Array[DomeWeapon]
var weaponIndex: int = 0

func _ready():
    equip_weapon(weapons[weaponIndex])

func active_weapon() -> DomeWeapon:
    return weapons[weaponIndex]

func next_weapon() -> void:
    if !switch_cooldown.is_stopped():
        return

    weaponIndex += 1
    weaponIndex %= weapons.size()
    equip_weapon(active_weapon())
    switch_cooldown.start()

func equip_weapon(weapon: DomeWeapon) -> void:
    for w in weapons:
        w.set_active(false)

    weapon.set_active(true)
    AudioManager.play_sound("switch_weapon")

func _process(_delta):
    if Input.is_action_just_pressed("switch_weapon"):
        next_weapon()