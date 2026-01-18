extends Bullet

func can_hit(body: Node2D) -> bool:
    return body.is_in_group("Player")

func hit_something(player: Node2D) -> void:
    player.takeDmg(dmg)
    destroy()