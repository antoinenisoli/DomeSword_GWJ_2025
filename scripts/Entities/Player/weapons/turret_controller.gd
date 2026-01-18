extends DomeWeapon
class_name Turret

@export_category("Shooting")
@export var _shooting: Shooting
@export var sprite: AnimatedSprite2D
@export var light: Sprite2D
@export var grad: Gradient
@export var ammo_container: AmmoContainer

@export_category("Rotation")
@export var rotate_speed: float = 0.8
@export_range(0, 360) var rot_limit: float = 80

@export_category("Low Ammo Blink")
@export_range(0, 1) var low_ammo: float = 0.5
@export var blink: Color = Color.RED
@export var blink_rate: int = 32

func _ready():
    super ()
    _shooting.on_bullet_shot.connect(on_bullet_shot)
    EventManager.on_sword_hit.connect(ammo_from_sword)

func update_light() -> void:
    var i = ammo_container.ammo_quantity()
    var color: Color = grad.sample(i)
    light.self_modulate = color
    if i <= low_ammo && i > 0:
        light.self_modulate = color if Engine.get_process_frames() % blink_rate else blink

func ammo_from_sword(dmg: int) -> void:
    ammo_container.add_ammo(dmg)

func on_bullet_shot(bullet) -> void:
    if !sprite.is_playing():
        sprite.play("shoot")
    
    bullet.init(self)
    ammo_container.shoot()

func look_mouse(_delta: float) -> void:
    var mousePos = get_global_mouse_position()
    var v = mousePos - global_position
    var angle = v.angle()
    var r = global_rotation

    #lerp angle towards the mouse
    var angle_delta = rotate_speed * _delta
    angle = lerp_angle(r, angle + deg_to_rad(90), 1.0)
    angle = clamp(angle, r - angle_delta, r + angle_delta)
    global_rotation = angle

    #limit the rotation
    var limit = deg_to_rad(rot_limit)
    global_rotation = clamp(global_rotation, -limit, limit)

func rotate_turret(_delta: float) -> void:
    var m = Input.get_axis("move_left", "move_right")
    rotation += m * rotate_speed * _delta
    var limit = deg_to_rad(rot_limit)
    rotation = clamp(rotation, -limit, limit)

func _process(_delta: float):
    rotate_turret(_delta)
    update_light()
    if Input.is_action_pressed("fire") && ammo_container.can_shoot:
        _shooting.shoot()
