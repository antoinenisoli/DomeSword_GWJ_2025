extends Entity
class_name Enemy

@onready var follow = get_parent() as Follow

@export var _shooting: Shooting
@export var anim: AnimationPlayer
@export var ammo_value: int = 10
@export var grow_duration: float = 1.2
@export var target: Node2D
@export var type: Enums.ENEMY_TYPE

func _ready():
    sprite.get_parent().scale = Vector2.ZERO
    super ()
    
    find_target()
    await get_tree().process_frame # wait for the position to be set
    grow_effect()

func find_target() -> void:
    var group = get_tree().get_nodes_in_group("Player")
    if !group.is_empty():
        target = get_tree().get_nodes_in_group("Player")[0]
        follow.target = target
    elif !follow.target:
        follow.target = target

func reset() -> void:
    sprite.play("idle")

func shoot():
    if !target:
        return
        
    _shooting.look_at(target.position)
    _shooting.shoot()

func grow_effect() -> void:
    var x: float = -1 if target.position.x < global_position.x else 1
    var newScale = Vector2(x, 1)

    var tween := create_tween()
    tween.tween_property(sprite.get_parent(), "scale", newScale, grow_duration)
    tween.play()

func _process(_delta):
    if !target:
        reset()
        return

    if follow.enemy_state == Enums.ENEMY_STATE.MOVING:
        sprite.play("move")
    else:
        reset()
        shoot()

func death() -> void:
    FxManager.spawn_fx("blood_explode", global_position)
    EventManager.on_enemy_killed.emit(ammo_value)

    anim.play("death_jump")
    var shadow = sprite.get_children()[0]
    if shadow:
        shadow.queue_free()

    follow.process_mode = Node.PROCESS_MODE_DISABLED
    await anim.animation_finished
    get_parent().queue_free()

func _on_damage_taken(_hp) -> void:
    pass
    #FxManager.spawn_fx("blood_slash", global_position)
