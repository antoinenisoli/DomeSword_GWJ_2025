extends Node2D

@export var canvas: CanvasLayer
@export var gameover_screen: PackedScene

func _ready():
    EventManager.on_player_killed.connect(game_over)

func game_over() -> void:
    var screen = gameover_screen.instantiate()
    canvas.add_child(screen)
    TimeManager.set_time(0.1)

    await get_tree().create_timer(2, true, true, true).timeout
    TimeManager.reset_time()
    get_tree().reload_current_scene()