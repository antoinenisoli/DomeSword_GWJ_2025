extends Node2D

@export var collision_ray: RayCast2D
@export var avoidance_ray: RayCast2D
@export var line: Line2D
@export var body: RigidBody2D
@export var max_ahead: float = 100
@export var max_avoidance: float = 100

func avoid_obstacle(obstacle_center: Vector2):
	print(obstacle_center)
	line.set_point_position(1, line.to_local(obstacle_center))

	var avoidance_force: Vector2 = collision_ray.target_position - obstacle_center
	avoidance_force = avoidance_force.normalized() * max_avoidance
	avoidance_ray.target_position = avoidance_force

func _process(_delta):
	collision_ray.target_position = body.linear_velocity.normalized() * max_ahead
	line.set_point_position(0, Vector2(0, 0))
	
	if collision_ray.is_colliding():
		avoid_obstacle(collision_ray.get_collider().position)
	else:
		avoidance_ray.target_position = Vector2(0, 0)
