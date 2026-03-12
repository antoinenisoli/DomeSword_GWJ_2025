extends Node2D

@export var _timer: Timer
@export var waves: Array[Spawner]
var index: int = 0

func _ready():
	EventManager.on_game_started.connect(start_game)

func last_wave() -> Spawner: return waves[waves.size() - 1]

func start_game():
	waves[0].start()
	_timer.wait_time = last_wave().time_frame.y
	_timer.start()
	
func _process(_delta):
	var elapsedTime = _timer.wait_time - _timer.time_left
	if !_timer.is_stopped():
		print(roundf(elapsedTime))
	else:
		print("all waves completed!")
		return

	if waves.size() != 0 && (index + 1) < waves.size():
		var next = waves[index + 1]
		var current = waves[index]
		if elapsedTime > next.time_frame.x && elapsedTime < next.time_frame.y:
			current.stop()
			next.start()
			index += 1
