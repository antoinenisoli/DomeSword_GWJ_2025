extends Bullet

var shooter: Turret

func init(turret: Turret) -> void:
    shooter = turret

func can_hit(body: Node2D) -> bool:
    return body.is_in_group("Enemies") && shooter.can_hit(body.enemy)

func hit_something(body: Node2D) -> void:
    FxManager.spawn_fx("blood_slash", body.position)
    body.enemy.takeDmg(dmg)
    destroy()