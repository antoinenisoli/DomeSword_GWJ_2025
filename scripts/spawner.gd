extends Node2D
class_name Spawner

@export var cooldown_range: Vector2
@export var spawn_range: float = 100
@export var enemy: PackedScene
@export var cooldown: Timer

func _ready():
    cooldown.wait_time = randf_range(cooldown_range.x, cooldown_range.y)
    cooldown.start()

func _on_cooldown_timeout() -> void:
    spawn()

func spawn_enemy() -> void:
    var _enemy = enemy.instantiate()
    get_tree().current_scene.add_child(_enemy)

    var randomOffset = (Vector2.RIGHT * randf_range(0, spawn_range)).rotated(randf_range(0, PI))
    #print(randomOffset)
    _enemy.position = position + randomOffset
    _enemy.rotation = rotation

func spawn():
    spawn_enemy()
    cooldown.wait_time = randf_range(cooldown_range.x, cooldown_range.y)
    #print(cooldown.wait_time)
    pass
