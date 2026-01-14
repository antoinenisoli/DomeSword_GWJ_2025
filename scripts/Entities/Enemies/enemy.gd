extends Entity

@export var _stats: Stats
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(_delta: float):
	var dir = position.distance_to(player.position)
	#print(dir)

	if dir > _stats.min_distance:
		sprite.play("move")
		var direction: Vector2 = (player.position - position).normalized()
		velocity = direction * _stats.move_speed
	else:
		sprite.play("idle")
		velocity = Vector2.ZERO
		
	move_and_slide()
