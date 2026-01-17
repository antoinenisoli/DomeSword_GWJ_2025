extends Node2D
class_name DomeWeapon

var container: Node2D

func _ready():
    container = get_parent()

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
