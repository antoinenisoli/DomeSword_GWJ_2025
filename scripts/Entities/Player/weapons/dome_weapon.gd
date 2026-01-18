extends Node2D
class_name DomeWeapon

@export var match_enemies: Array[Enums.ENEMY_TYPE] = []
var weapons: WeaponInventory

func _ready():
    weapons = get_parent()

func can_hit(target: Enemy) -> bool:
    var match: bool = target.is_in_group("Enemies") && match_enemies.has(target.type)
    #print(match)
    return match

func equip() -> void:
    if !is_visible_in_tree():
        weapons.add_child(self)

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
