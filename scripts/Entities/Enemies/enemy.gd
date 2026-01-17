extends Entity

@export var _shooting: Shooting
@export var speed: float = 100
@export var max_speed: float = 1000
@export var min_distance: float = 200
@export var target: Node2D
@export var push_cooldown: Timer

var player: Turret
var _target: Node2D: get = get_target

func _ready():
    super ()
    var group = get_tree().get_nodes_in_group("Player")
    #print(group.is_empty())
    if !group.is_empty():
        player = get_tree().get_nodes_in_group("Player")[0]

func direction() -> Vector2:
    return (_target.position - position).normalized()

func get_target() -> Node2D:
    if player:
        return player
    else:
        return target

func reset() -> void:
    sprite.play("idle")
    stop()

func stop() -> void:
    linear_velocity = Vector2.ZERO

func shoot():
    if !_target:
        return
        
    _shooting.look_at(_target.position)
    _shooting.shoot()

func _physics_process(_delta: float):
    if !_target:
        reset()
        return

    var dir = position.distance_to(_target.position)
    #print(dir)
    if dir > min_distance:
        sprite.play("move")
        apply_force(direction() * speed)
    elif linear_velocity.length() > 0.1:
        reset()
        shoot()
    
func _process(_delta):
    if !_target:
        return

    sprite.flip_h = _target.position.x < position.x

func push_back(force: float) -> void:
    if !push_cooldown.is_stopped():
        return

    print("push back")
    push_cooldown.start()
    stop()
    apply_impulse(-direction() * force)

func death() -> void:
    FxManager.spawn_fx("blood_explode", position)
    super ()

func _on_damage_taken(_hp) -> void:
    pass
    #FxManager.spawn_fx("blood_slash", position)
