extends Camera2D

@export var shakers: Dictionary[String, CameraShake]
@export var shake_duration = 0.1
@export var shake_amount = 10

var current_shake = 0

func _ready():
    EventManager.on_player_damaged.connect(func f(_t = 0) -> void:
        play_shaker("player_hit"))

    EventManager.on_sword_hit.connect(func f(_dmg: int) -> void:
        play_shaker("sword_hit"))

func play_shaker(_name: String) -> void:
    if !shakers.has(_name):
        print(_name + " doesn't exist.")
        return

    var shaker: CameraShake = shakers.get(_name)
    use_shaker(shaker)

func use_shaker(shaker: CameraShake) -> void:
    current_shake = shaker.shake_amount
    shake_duration = shaker.shake_duration

func shake(_t = 0) -> void:
    current_shake = shake_amount

func manage_shake(delta) -> void:
    current_shake -= shake_amount * delta / shake_duration
    if current_shake < 0:
        current_shake = 0
        
    offset = Vector2(randf_range(-current_shake, current_shake), randf_range(-current_shake, current_shake))

func _process(delta):
    manage_shake(delta)
