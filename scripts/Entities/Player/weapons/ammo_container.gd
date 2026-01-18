extends Resource
class_name AmmoContainer

signal out_of_ammo

@export var start_ammo: int = 10
@export var max_ammo: int
var ammo: int: set = _on_ammo_set
var can_shoot: bool = true

func _init() -> void:
    setup.call_deferred()

func setup() -> void:
    ammo = start_ammo

func _on_ammo_set(new_value: int) -> void:
    ammo = new_value
    if ammo <= 0:
        ammo = 0
        out_of_ammo.emit()

    if ammo > max_ammo:
        ammo = max_ammo

    can_shoot = ammo > 0

func shoot(amount: int = 1) -> void:
    ammo -= amount
    #print(ammo)

func ammo_quantity() -> float:
    return (ammo as float) / (max_ammo as float)