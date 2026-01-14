extends Entity

@export var _shooting: Shooting
@export var _stats: Stats
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func reset() -> void:
	sprite.play("idle")
	velocity = Vector2.ZERO

func shoot():
	_shooting.look_at(player.position)
	_shooting.shoot()

func _physics_process(_delta: float):
	if !player:
		reset()
		return

	var dir = position.distance_to(player.position)
	#print(dir)
	if dir > _stats.min_distance:
		sprite.play("move")
		var direction: Vector2 = (player.position - position).normalized()
		velocity = direction * _stats.move_speed
		move_and_slide()
	else:
		reset()
		shoot()
	
func _process(_delta):
	sprite.flip_h = player.position.x < position.x