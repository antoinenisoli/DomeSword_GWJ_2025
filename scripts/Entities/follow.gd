extends RigidBody2D
class_name Follow

@export var speed: float = 100
@export var min_distance: float = 300
@export var target: Node2D
@export var enemy: Enemy
@export var push_cooldown: Timer
var enemy_state: Enums.ENEMY_STATE

func direction() -> Vector2:
    if !target:
        return Vector2.ZERO

    return (target.position - position).normalized()

func stop() -> void:
    enemy_state = Enums.ENEMY_STATE.IDLE
    linear_velocity = Vector2.ZERO

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    state.linear_velocity = state.linear_velocity.limit_length(speed)

func _physics_process(_delta):
    if !target:
        return

    var dir = global_position.distance_to(target.position)
    if dir > min_distance:
        apply_force(direction() * speed)
        enemy_state = Enums.ENEMY_STATE.MOVING
    elif linear_velocity.length() > 0.1:
        stop()

func push_back(force: float) -> void:
    if !push_cooldown.is_stopped():
        return

    #print("push back")
    push_cooldown.start()
    linear_velocity = Vector2.ZERO
    apply_impulse(-direction() * force)
