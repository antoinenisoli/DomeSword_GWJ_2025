extends Entity
class_name Dome

@export var weapons: Array[DomeWeapon]
var weaponIndex: int = 0

func _ready():
    super ()
    equip_weapon(weapons[weaponIndex])

func equip_weapon(weapon: DomeWeapon) -> void:
    for w in weapons:
        w.set_active(false)

    weapon.set_active(true)

func _process(_delta):
    if Input.is_action_just_pressed("switch_weapon"):
        weaponIndex += 1
        weaponIndex %= weapons.size()
        equip_weapon(weapons[weaponIndex])
        pass
