extends Node2D

@export var fx_list: Dictionary[String, PackedScene] = {}

func spawn_fx(fx_name: String, _position: Vector2) -> Node2D:
    if !fx_list.has(fx_name):
        print(fx_name + " not found in the fx list.")
        return

    var scene: PackedScene = fx_list.get(fx_name)
    var fx = scene.instantiate()
    get_tree().current_scene.add_child(fx)
    fx.position = _position
    return fx