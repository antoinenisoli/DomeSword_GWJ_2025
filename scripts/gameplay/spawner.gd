extends Node2D
class_name Spawner

@export var cooldown: Timer
@export var waveTimer: Timer
@export var spawn_range: float = 100
@export var cooldown_range: Vector2
@export var enemies: Array[PackedScene]
@export var spawnPoints: Array[Node2D]
var waveDone: bool

func start():
    waveTimer.start()
    cooldown.wait_time = randf_range(cooldown_range.x, cooldown_range.y)
    cooldown.start()
    print("start wave ", waveTimer.wait_time)
    pass

func _on_wave_timeout() -> void:
    cooldown.stop()
    waveDone = true
    #print("stop wave ", time_frame.x, time_frame.y)

func _on_cooldown_timeout() -> void:
    spawn()

func spawn_enemy() -> void:
    var _enemy = enemies.pick_random().instantiate()
    get_tree().current_scene.add_child(_enemy)

    var randomOffset = (Vector2.RIGHT * randf_range(0, spawn_range)).rotated(randf_range(0, PI))
    #print(randomOffset)
    var spawnArea = spawnPoints.pick_random()
    _enemy.position = spawnArea.position + randomOffset
    _enemy.rotation = rotation

func spawn():
    spawn_enemy()
    cooldown.wait_time = randf_range(cooldown_range.x, cooldown_range.y)
    #print(cooldown.wait_time)
    pass