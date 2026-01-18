extends Entity
class_name Dome

func death() -> void:
    EventManager.on_player_killed.emit()
    super ()

func takeDmg(dmg: int) -> void:
    super (dmg)
    AudioManager.play_sound("player_hit")
    EventManager.on_player_damaged.emit()
