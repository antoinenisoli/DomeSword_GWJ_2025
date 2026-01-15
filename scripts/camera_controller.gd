extends Camera2D

@export var shake_duration = 0.1
@export var shake_amount = 10
@export var turret: Turret

var current_shake = 0

func _ready():
    print(turret)
    turret.damage_taken.connect(shake)

func shake(_t = 0) -> void:
    current_shake = shake_amount

func manage_shake(delta) -> void:
    current_shake -= shake_amount * delta / shake_duration
    if current_shake < 0:
        current_shake = 0
        
    offset = Vector2(randf_range(-current_shake, current_shake), randf_range(-current_shake, current_shake))

func _process(delta):
    manage_shake(delta)
    if Input.is_action_just_pressed("ui_accept"):
        shake()
