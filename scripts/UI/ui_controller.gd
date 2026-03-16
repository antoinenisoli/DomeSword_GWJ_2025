extends Control

@export var enemy_txt: Label
@export var wave_txt: Label
@export var time_txt: Label
@export var tuto_Txt: Label
@export var pause_screen: Control
@export var gameover_screen: Control
@export var floating_txt: PackedScene

func _ready() -> void:
	enemy_txt.text = str(0)
	gameover_screen.visible = false
	EventManager.collect_ammo.connect(spawn_ammo_text)
	EventManager.on_game_started.connect(hide_tuto)
	EventManager.on_game_win.connect(game_over)
	
	EventManager.on_player_killed.connect(game_over)
	EventManager.on_enemy_killed.connect(func f(_args) -> void:
		enemy_txt.text = str(GameManager.enemy_killed)
		)

	set_paused(true)

func spawn_ammo_text(ammo_value: int, pos: Vector2) -> void:
	if floating_txt:
		#print("ammo txt!")
		var text = floating_txt.instantiate()
		get_tree().current_scene.add_child(text)
		text.global_position = pos
		text.set_text(str(ammo_value))

func game_over() -> void:
	gameover_screen.visible = true
	TimeManager.set_time(0.1)

	await get_tree().create_timer(2, true, true, true).timeout
	TimeManager.reset_time()
	get_tree().reload_current_scene()

func set_paused(b: bool) -> void:
	var t = 0 if b else 1
	TimeManager.set_time(t)
	pause_screen.visible = b

func _on_resume_button_pressed() -> void:
	set_paused(false)
	if !GameManager.tutoDone:
		tuto_Txt.visible = true

func hide_tuto() -> void:
	tuto_Txt.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _process(_delta):
	wave_txt.text = str(GameManager.waveData.x) + "/" + str(GameManager.waveData.y)
	time_txt.text = str(GameManager.game_time)
	if Input.is_action_just_pressed("pause_game") && !pause_screen.visible:
		set_paused(true)
