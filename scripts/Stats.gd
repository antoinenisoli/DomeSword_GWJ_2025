extends Resource
class_name Stats

signal entity_death

@export var max_hp: int = 100
@export var attack: int = 1
@export var shoot_rate: float = 5
var current_hp: int = 0: set = _on_hp_set

func _on_hp_set(new_value: int) -> void:
    current_hp = new_value
    if current_hp <= 0:
        current_hp = 0
        entity_death.emit()

    if current_hp > max_hp:
        current_hp = max_hp

func _to_string() -> String:
    return str(current_hp, "/", max_hp)

func _init() -> void:
    setup_stats.call_deferred()

func setup_stats() -> void:
    current_hp = max_hp
    print(current_hp)