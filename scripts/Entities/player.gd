extends Node2D

@export var bullet: PackedScene
@export var reload_timer: Timer
@export var aim: RayCast2D
@export var shootPos: Node2D

func shoot() -> void:
	if !reload_timer.is_stopped() || !bullet:
		return

	if bullet && shootPos:
		#print("shoot!")
		var newB = bullet.instantiate()
		get_tree().current_scene.add_child(newB)
		newB.global_position = shootPos.position
		newB.global_rotation = shootPos.rotation
		reload_timer.start()

func _process(_delta):
	#print(reload_timer.is_stopped())
	if Input.is_action_pressed("fire"):
		shoot()

func _on_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
