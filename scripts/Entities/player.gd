extends Entity
class_name Player

@export var _shooting: Shooting
@export var rotate_speed: float = 150
@export var rot_limit: float = 70

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
    #print(reload_timer.is_stopped())
    #look_mouse(_delta)
    rotate_turret(_delta)
    if Input.is_action_pressed("fire"):
        _shooting.shoot()
