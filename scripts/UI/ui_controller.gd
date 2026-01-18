extends Control

@export var enemy_txt: Label
@export var flame_txt: Label
@export var pause_screen: Control
@export var gameover_screen: Control
@export var floating_txt: PackedScene
var enemy_killed: int

func _ready() -> void:
    enemy_txt.text = str(0)
    flame_txt.text = str(0)
    pause_screen.visible = false
    gameover_screen.visible = false
    EventManager.collect_ammo.connect(spawn_ammo_text)
    EventManager.on_player_killed.connect(game_over)
    EventManager.on_enemy_killed.connect(func f(_args) -> void:
        enemy_killed += 1
        enemy_txt.text = str(enemy_killed)
        )

func spawn_ammo_text(ammo_value: int, pos: Vector2) -> void:
    if floating_txt:
        #print("ammo txt!")
        var text = floating_txt.instantiate()
        get_tree().current_scene.add_child(text)
        text.global_position = pos
        text.set_text(str(ammo_value))

func game_over() -> void:
    pause_screen.visible = true
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

func _on_quit_button_pressed() -> void:
    get_tree().quit()

func _process(_delta):
    if Input.is_action_just_pressed("pause_game") && !pause_screen.visible:
        set_paused(true)