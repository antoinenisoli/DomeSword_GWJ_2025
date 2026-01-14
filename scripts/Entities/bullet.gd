extends Area2D

var right = Vector2.RIGHT
@export var dmg: int = 1
@export var speed: float = 15

func _physics_process(delta):
	var move = right.rotated(rotation) * speed * delta
	global_position += move

func destroy() -> void:
	#print("destroy " + str(self))
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	print(body)
	body.takeDmg(dmg)
	destroy()

func _on_screen_exited() -> void:
	destroy()
