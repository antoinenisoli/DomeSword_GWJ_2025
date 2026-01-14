extends ProgressBar
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
    player.damage_taken.connect(update_health)
    await get_tree().process_frame
    value = player.health_value()

func update_health(player_health: float) -> void:
    value = player_health
    #print("player health: " + str(player_health))