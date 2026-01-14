extends CharacterBody2D
class_name Entity

@export var _health: Health
@export var sprite: AnimatedSprite2D
@export var hitColor: Color

func _ready() -> void:
	_health.on_death.connect(death)
	await get_tree().process_frame

func hit_flash() -> void:
	sprite.self_modulate = hitColor
	await get_tree().create_timer(0.1).timeout
	sprite.self_modulate = Color.WHITE # reset to default

func takeDmg(dmg: int) -> void:
	_health.current_hp -= dmg
	hit_flash()

func death() -> void:
	queue_free()
