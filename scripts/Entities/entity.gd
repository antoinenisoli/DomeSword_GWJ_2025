extends CharacterBody2D
class_name Entity

@export var sprite: AnimatedSprite2D
@export var hitColor: Color
@export var _health: Health

func _ready() -> void:
	_health.on_death.connect(death)
	await get_tree().process_frame
	print(_health)

func hit_flash() -> void:
	sprite.self_modulate = hitColor
	await get_tree().create_timer(0.1).timeout
	sprite.self_modulate = Color.WHITE # reset to default

func takeDmg() -> void:
	_health.current_hp -= 1
	print(_health.current_hp)
	hit_flash()

func death() -> void:
	print("i'm dead!!")
	queue_free()
