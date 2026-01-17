extends RigidBody2D
class_name Follow

@export var enemy: Enemy
@export var target: Node2D
@export var speed: float = 100
@export var min_distance: float = 300
var enemy_state: Enums.ENEMY_STATE

func direction() -> Vector2:
    if !target:
        return Vector2.ZERO

    return (enemy.target.position - position).normalized()

func stop() -> void:
    enemy_state = Enums.ENEMY_STATE.IDLE
    linear_velocity = Vector2.ZERO

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    state.linear_velocity = state.linear_velocity.limit_length(speed)

func _physics_process(_delta):
    var dir = global_position.distance_to(target.position)
    if dir > min_distance:
        apply_force(direction() * speed)
        enemy_state = Enums.ENEMY_STATE.MOVING
    elif linear_velocity.length() > 0.1:
        stop()

func push_back(force: float) -> void:
    #print("push back")
    linear_velocity = Vector2.ZERO
    apply_impulse(-direction() * force)

func takeDmg(dmg: int) -> void:
    enemy.takeDmg(dmg)
