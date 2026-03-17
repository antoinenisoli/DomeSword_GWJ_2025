extends Node2D

@export var _timer: Timer
@export var waves: Array[Spawner]
var index: int = 0

func _ready():
	EventManager.on_game_started.connect(start_game)
	GameManager.waveData = Vector2(0, waves.size())

func get_game_duration() -> float:
	var duration = 0
	for w in waves:
		duration += w.waveTimer.wait_time
	
	return duration

func start_game():
	GameManager.waveData = Vector2(1, waves.size())
	waves[index].start(1)
	print("start wave ", 1)

	_timer.wait_time = get_game_duration()
	_timer.start()

func end_game():
	print("all waves completed!")
	GameManager.waveData = Vector2(waves.size(), waves.size())
	EventManager.on_game_win.emit()
	
func _process(_delta):
	GameManager.game_time = roundi(_timer.time_left)
	#print(index, " ", waves.size())

	var current = waves[index]
	if current.waveDone:
		if index + 1 == waves.size():
			end_game()
		else:
			var next = waves[index + 1]
			next.start(1)
			print("wave ", index, " completed!")
			index += 1
			GameManager.waveData = Vector2(index, waves.size())
