extends Node2D
class_name Shooting

signal on_bullet_shot

@export var bullet: PackedScene
@export var shoot_rate: float = 0.5
@export var reload_timer: Timer
@export var shootPos: Node2D

func shoot() -> void:
    if !reload_timer.is_stopped() || !bullet:
        return

    if bullet && shootPos:
        #print("shoot!")
        var newB = bullet.instantiate()
        get_tree().current_scene.add_child(newB)
        newB.position = shootPos.global_position
        newB.rotation = shootPos.global_rotation
        on_bullet_shot.emit(newB)
        reload_timer.start()

func _ready() -> void:
    reload_timer.wait_time = shoot_rate
