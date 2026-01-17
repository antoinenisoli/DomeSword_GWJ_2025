extends RigidBody2D
class_name Follow

@export var enemy: Enemy
@export var target: Node2D
@export var speed: float = 100

func direction() -> Vector2:
    if !target:
        return Vector2.ZERO

    return (enemy.target.position - position).normalized()

func stop() -> void:
    linear_velocity = Vector2.ZERO

func follow_target(_delta):
    apply_force(direction() * speed)

func push_back(force: float) -> void:
    #print("push back")
    linear_velocity = Vector2.ZERO
    apply_impulse(-direction() * force)

func takeDmg(dmg: int) -> void:
    enemy.takeDmg(dmg)
