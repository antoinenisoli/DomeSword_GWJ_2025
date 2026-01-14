extends StaticBody2D

@export var bullet: PackedScene
@export var reload_timer: Timer
@export var shootPos: Node2D
@export var rotate_speed: float = 150
@export var rot_limit: float = 110

func shoot() -> void:
	if !reload_timer.is_stopped() || !bullet:
		return

	if bullet && shootPos:
		#print("shoot!")
		var newB = bullet.instantiate()
		get_tree().current_scene.add_child(newB)
		newB.position = shootPos.global_position
		newB.rotation = shootPos.global_rotation
		reload_timer.start()

func control_turret(_delta: float) -> void:
	var mousePos = get_global_mouse_position()
	var rot = transform.looking_at(mousePos).get_rotation()
	rot += deg_to_rad(90)
	var f = fposmod(rad_to_deg(rot), -360)
	print(rad_to_deg(rot))
	rotation = rot

func _process(_delta):
	#print(reload_timer.is_stopped())
	control_turret(_delta)
	if Input.is_action_pressed("fire"):
		shoot()

func _on_body_entered(_body: Node2D) -> void:
	print(_body)
