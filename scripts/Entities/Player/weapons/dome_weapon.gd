extends Node2D
class_name DomeWeapon

signal on_weapon_equiped

@onready var weapons: WeaponInventory = get_parent()
@onready var weapon_support: WeaponSupport = weapons.get_parent()

@export var collect_enabled: bool
@export_range(0, 360) var rot_limit: float = 70
@export var match_enemies: Array[Enums.ENEMY_TYPE] = []

func can_hit(target: Enemy) -> bool:
    var match: bool = target.is_in_group("Enemies") && match_enemies.has(target.type)
    #print(match)
    return match

func equip() -> void:
    if !is_visible_in_tree():
        weapons.add_child(self)
        on_weapon_equiped.emit()

func unequip() -> void:
    if is_visible_in_tree():
        weapons.remove_child(self)

func reset() -> void:
    assert(false, "Please override `reset()` in the derived script.")

func set_active(b: bool) -> void:
    reset()
    if b:
        equip()
    else:
        unequip()
