extends Area2D
class_name Bullet

var right = Vector2.RIGHT
@export var dmg: int = 1
@export var speed: float = 15

func _physics_process(delta):
    var move = right.rotated(rotation) * speed * delta
    global_position += move

func destroy() -> void:
    #print("destroy " + str(self))
    queue_free()

func hit_something(_body: Node2D) -> void:
    assert(false, "Please override `hit_something()` in the derived script.")

func can_hit(_body: Node2D) -> bool:
    assert(false, "Please override `can_hit()` in the derived script.")
    return false

func _on_body_entered(body: Node2D) -> void:
    if can_hit(body):
        hit_something(body)

func _on_screen_exited() -> void:
    destroy()
