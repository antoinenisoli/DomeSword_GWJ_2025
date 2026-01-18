extends Node2D
class_name WeaponSupport

@export var anchor: Node2D
@export var sprite: AnimatedSprite2D
@export var anim: AnimationPlayer
@export var weapons: WeaponInventory

@export_category("Low Ammo Blink")
@export var light: Sprite2D
@export var grad: Gradient
@export_range(0, 1) var low_ammo: float = 0.5
@export var blink: Color = Color.RED
@export var blink_rate: int = 32

func show_sword() -> void:
    sprite.play("open")
    await sprite.animation_finished
    anim.play("show_sword")
    await anim.animation_finished

func show_turret() -> void:
    anim.play("hide_sword")
    await anim.animation_finished
    sprite.play("close")
    await sprite.animation_finished

func update_light() -> void:
    if !weapons:
        return

    var i = weapons.turret_ammo.ammo_quantity()
    var color: Color = grad.sample(i)
    light.self_modulate = color
    if i <= low_ammo && i > 0:
        light.self_modulate = color if Engine.get_process_frames() % blink_rate else blink

func add_rot(degrees: float) -> void:
    anchor.global_rotation_degrees += degrees

func _on_turret_equiped() -> void:
    print("equip turret")
    show_turret()

func _on_sword_equiped() -> void:
    print("equip sword")
    show_sword()

func _process(_delta):
    update_light()
