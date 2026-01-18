extends Node2D
class_name Entity

signal damage_taken

@export var _health: Health
@export var sprite: AnimatedSprite2D
@export var hitColor: Color

func _ready() -> void:
    _health.on_death.connect(death)

func health_value() -> float:
    return _health.current_hp as float / _health.max_hp as float

func hit_flash() -> void:
    sprite.self_modulate = hitColor
    await get_tree().create_timer(0.1, true, true, true).timeout
    sprite.self_modulate = Color.WHITE # reset to default

func takeDmg(dmg: int) -> void:
    #print(str(dmg) + " damage received!")
    _health.current_hp -= dmg
    damage_taken.emit(health_value())
    hit_flash()

func death() -> void:
    await get_tree().process_frame
    queue_free()
