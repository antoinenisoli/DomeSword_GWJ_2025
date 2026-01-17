extends Entity

@export var _shooting: Shooting
@export var _stats: Stats
@export var target: Node2D

var player: Turret
var _target: Node2D: get = get_target

func _ready():
    super ()
    var group = get_tree().get_nodes_in_group("Player")
    #print(group.is_empty())
    if !group.is_empty():
        player = get_tree().get_nodes_in_group("Player")[0]

func get_target() -> Node2D:
    if player:
        return player
    else:
        return target

func reset() -> void:
    sprite.play("idle")
    velocity = Vector2.ZERO

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
    if dir > _stats.min_distance:
        sprite.play("move")
        var direction: Vector2 = (_target.position - position).normalized()
        velocity = direction * _stats.move_speed
        move_and_slide()
    else:
        reset()
        shoot()
    
func _process(_delta):
    if !_target:
        return

    sprite.flip_h = _target.position.x < position.x

func _on_damage_taken(_hp) -> void:
    pass
    #FxManager.spawn_fx("blood_slash", position)
