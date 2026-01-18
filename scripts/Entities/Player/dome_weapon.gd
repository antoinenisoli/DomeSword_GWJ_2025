extends Node2D
class_name DomeWeapon

@export var match_enemies: Array[Enums.ENEMY_TYPE] = []
var container: Node2D

func _ready():
    container = get_parent()

func can_hit(target: Enemy) -> bool:
    print(match_enemies.has(target.type))
    var match: bool = target.is_in_group("Enemies") && match_enemies.has(target.type)
    return match

func equip() -> void:
    if !is_visible_in_tree():
        container.add_child(self)

func unequip() -> void:
    if is_visible_in_tree():
        container.remove_child(self)

func set_active(b: bool) -> void:
    if b:
        equip()
    else:
        unequip()
