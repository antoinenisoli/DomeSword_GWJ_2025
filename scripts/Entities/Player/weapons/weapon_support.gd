extends Node2D
class_name WeaponSupport

@export var sprite: AnimatedSprite2D
@export var anim: AnimationPlayer

@export_category("Low Ammo Blink")
@export var my_weapon: DomeWeapon
@export var light: Sprite2D
@export var grad: Gradient
@export_range(0, 1) var low_ammo: float = 0.5
@export var blink: Color = Color.RED
@export var blink_rate: int = 32
var switching: bool = false

func show_sword() -> void:
    switching = true
    sprite.play("open")
    await sprite.animation_finished
    anim.play("show_sword")
    await anim.animation_finished
    switching = false

func show_turret() -> void:
    switching = true
    anim.play("hide_sword")
    await anim.animation_finished
    sprite.play("close")
    await sprite.animation_finished
    switching = false

func update_light() -> void:
    if !my_weapon:
        return

    var i = my_weapon.weapons.turret_ammo.ammo_quantity()
    var color: Color = grad.sample(i)
    light.self_modulate = color
    if i <= low_ammo && i > 0:
        light.self_modulate = color if Engine.get_process_frames() % blink_rate else blink

func _process(_delta):
    update_light()

    if Input.is_physical_key_pressed(KEY_T) && !switching:
        show_sword()
    if Input.is_physical_key_pressed(KEY_Y) && !switching:
        show_turret()
