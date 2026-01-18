extends Area2D

@export var damages: int = 15

func scan_enemy(entity) -> void:
    print(entity)
    if entity.is_in_group("Enemies"):
        FxManager.spawn_fx("blood_slash", entity.position)
        entity.enemy.takeDmg(damages)

func _on_body_entered(_body: Node2D) -> void:
    FxManager.spawn_fx("egg_explosion", position)
    for entity in get_overlapping_bodies():
        scan_enemy(entity)

    queue_free()
