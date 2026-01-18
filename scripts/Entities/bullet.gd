extends Area2D

var right = Vector2.RIGHT
var _team: Enums.TEAM
@export var dmg: int = 1
@export var speed: float = 15

func set_team(team: Enums.TEAM) -> void:
	_team = team

func _physics_process(delta):
	var move = right.rotated(rotation) * speed * delta
	global_position += move

func destroy() -> void:
	#print("destroy " + str(self))
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	var canDamage = (_team == Enums.TEAM.ALLY && body.is_in_group("Enemies")) || (_team == Enums.TEAM.ENEMY && body.is_in_group("Player"))
	if canDamage:
		if body.is_in_group("Enemies"):
			FxManager.spawn_fx("blood_slash", body.position)
			
		body.takeDmg(dmg)
		destroy()

func _on_screen_exited() -> void:
	destroy()
