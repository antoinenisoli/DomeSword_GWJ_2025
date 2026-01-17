extends RigidBody2D

@export var target: Node2D
@export var speed: float = 100
@export var max_speed: float = 1000

func direction() -> Vector2:
    return (target.position - position).normalized()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    state.linear_velocity = state.linear_velocity.normalized() * max_speed

func _physics_process(_delta):
    apply_force(direction() * speed)

func push_back(force: float) -> void:
    #print("push back")
    linear_velocity = Vector2.ZERO
    apply_impulse(-direction() * force)