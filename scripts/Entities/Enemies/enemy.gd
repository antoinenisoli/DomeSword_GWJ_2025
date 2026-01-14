extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var hitColor: Color
@export var _stats: Stats
var direction = 1

func _ready() -> void:
	_stats.entity_death.connect(death)
	await get_tree().process_frame
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
	velocity.x = direction * _stats.move_speed
	move_and_slide()
