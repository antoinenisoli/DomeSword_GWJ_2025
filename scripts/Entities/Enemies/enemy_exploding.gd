extends Enemy

@export var explosion: PackedScene
var done: bool

func death() -> void:
    spawn_explosion()
    super ()

func explode(_explosion: Node2D) -> void:
    #print("play: " + str(stream_player))
    get_tree().current_scene.add_child(_explosion)
    _explosion.position = global_position

func spawn_explosion() -> void:
    if done:
        return

    if explosion:
        print("explode!")
        done = true
        var e = explosion.instantiate()
        call_deferred("explode", e)

func _process(_delta):
    if !player:
        reset()
        return

    if follow.enemy_state == Enums.ENEMY_STATE.IDLE:
        death()