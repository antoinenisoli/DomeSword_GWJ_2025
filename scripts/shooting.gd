extends Node2D
class_name Shooting

@export var _team: Enums.TEAM
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
		newB.set_team(_team)
		get_tree().current_scene.add_child(newB)
		newB.position = shootPos.global_position
		newB.rotation = shootPos.global_rotation
		reload_timer.start()

func _ready() -> void:
	reload_timer.wait_time = shoot_rate