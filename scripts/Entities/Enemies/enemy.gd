extends Entity
class_name Enemy

@onready var follow = get_parent() as Follow

@export var _shooting: Shooting
@export var speed: float = 100
@export var max_speed: float = 1000
@export var min_distance: float = 200
@export var target: Node2D
@export var push_cooldown: Timer

func _ready():
    super ()
    var group = get_tree().get_nodes_in_group("Player")
    if !group.is_empty():
        target = get_tree().get_nodes_in_group("Player")[0]
        follow.target = target
    elif !follow.target:
        follow.target = target

func reset() -> void:
    sprite.play("idle")
    follow.stop()

func shoot():
    if !target:
        return
        
    _shooting.look_at(target.position)
    _shooting.shoot()

func _physics_process(_delta: float):
    if !target:
        reset()
        return

    var dir = global_position.distance_to(target.position)
    if dir > min_distance:
        sprite.play("move")
        follow.follow_target(_delta)
    elif follow.linear_velocity.length() > 0.1:
        reset()
        shoot()
    
func _process(_delta):
    if !target:
        return

    sprite.flip_h = target.position.x < global_position.x

func death() -> void:
    FxManager.spawn_fx("blood_explode", global_position)
    await get_tree().process_frame
    get_parent().queue_free()

func _on_damage_taken(_hp) -> void:
    pass
    #FxManager.spawn_fx("blood_slash", global_position)
