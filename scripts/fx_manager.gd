extends Node2D

@export var fx_list: Dictionary[String, PackedScene] = {}

func spawn_fx(fx_name: String, _position: Vector2) -> void:
    var o: PackedScene = fx_list.get(fx_name)
    print(o)
    var fx = o.instantiate()
    get_tree().current_scene.add_child(fx)
    fx.position = _position
