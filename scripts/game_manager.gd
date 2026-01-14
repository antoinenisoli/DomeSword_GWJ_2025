extends Node2D

@export var canvas: CanvasLayer
@export var gameover_screen: PackedScene

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
    player._health.on_death.connect(game_over)

func game_over() -> void:
    var screen = gameover_screen.instantiate()
    canvas.add_child(screen)
    Engine.time_scale = 0.1

    await get_tree().create_timer(2, true, true, true).timeout
    Engine.time_scale = 1
    get_tree().reload_current_scene()