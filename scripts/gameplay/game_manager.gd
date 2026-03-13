extends Node2D

var tutoDone: bool
var enemy_killed: int
var game_time: int
var waveData: Vector2i

func _ready():
	EventManager.on_enemy_killed.connect(on_kill)

func on_kill(_args):
	enemy_killed += 1