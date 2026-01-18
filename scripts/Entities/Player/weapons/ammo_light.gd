extends Node2D
class_name AmmoLight

@export var light: Sprite2D
@export var grad: Gradient
@export var my_weapon: DomeWeapon

@export_category("Low Ammo Blink")
@export_range(0, 1) var low_ammo: float = 0.5
@export var blink: Color = Color.RED
@export var blink_rate: int = 32

func update_light() -> void:
    var i = my_weapon.weapons.turret_ammo.ammo_quantity()
    var color: Color = grad.sample(i)
    light.self_modulate = color
    if i <= low_ammo && i > 0:
        light.self_modulate = color if Engine.get_process_frames() % blink_rate else blink

func _process(_delta):
    update_light()