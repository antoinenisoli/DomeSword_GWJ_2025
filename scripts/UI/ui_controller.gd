extends Control

@export var enemy_txt: Label
@export var flame_txt: Label
var enemy_killed: int

func _ready() -> void:
    enemy_txt.text = str(0)
    flame_txt.text = str(0)
    EventManager.on_enemy_killed.connect(func f(_args) -> void:
        enemy_killed += 1
        enemy_txt.text = str(enemy_killed)
        )
