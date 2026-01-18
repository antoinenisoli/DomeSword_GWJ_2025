extends Control

@export var enemy_txt: Label
@export var flame_txt: Label
@export var pause_screen: Control
@export var hud_screen: Control
var enemy_killed: int

func _ready() -> void:
    enemy_txt.text = str(0)
    flame_txt.text = str(0)
    EventManager.on_enemy_killed.connect(func f(_args) -> void:
        enemy_killed += 1
        enemy_txt.text = str(enemy_killed)
        )

func set_paused(b: bool) -> void:
    var t = 0 if b else 1
    TimeManager.set_time(t)
    pause_screen.visible = b

func _process(_delta):
    if Input.is_action_just_pressed("pause_game"):
        set_paused(!pause_screen.visible)