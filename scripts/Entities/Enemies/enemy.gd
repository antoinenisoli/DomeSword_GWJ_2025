extends Node2D

@export var _stats: Stats

func _ready():
    _stats.entity_death.connect(death)
    await get_tree().process_frame
    print(_stats)

func death() -> void:
    print("i'm dead!!")
    queue_free()

func _on_body_entered(body: Node2D) -> void:
    print(body)
