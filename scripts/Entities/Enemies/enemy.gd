extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var hitColor: Color
@export var min_distance: float = 50
@export var _stats: Stats

@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready() -> void:
	_stats.entity_death.connect(death)
	await get_tree().process_frame
	print(player)
	print(_stats)

func hit_flash() -> void:
	sprite.self_modulate = hitColor
	await get_tree().create_timer(0.1).timeout
	sprite.self_modulate = Color.WHITE # reset to default

func takeBullet() -> void:
	_stats.current_hp -= 1
	print(_stats.current_hp)
	hit_flash()

func death() -> void:
	print("i'm dead!!")
	queue_free()

func _physics_process(_delta: float):
	var dir = position.distance_to(player.position)
	print(dir)
	if dir > min_distance:
		sprite.play("move")
		var direction: Vector2 = (player.position - position).normalized()
		velocity = direction * _stats.move_speed
	else:
		sprite.play("idle")
		velocity = Vector2.ZERO
		
	move_and_slide()
