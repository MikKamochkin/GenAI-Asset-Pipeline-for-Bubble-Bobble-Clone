extends CharacterBody2D

@export var speed: float = 90.0
@export var gravity: float = 1100.0

var dir: int = -1
var trapped: bool = false


func set_trapped(v: bool) -> void:
	trapped = v
	if trapped:
		velocity = Vector2.ZERO
		set_physics_process(false)
	
		if self is CollisionObject2D:
			set_deferred("collision_layer", 0)
			set_deferred("collision_mask", 0)


func _physics_process(delta: float) -> void:
	if trapped:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	velocity.x = dir * speed
	move_and_slide()

	# Turn around when hitting a wall
	if is_on_wall():
		dir *= -1
		$Sprite2D.flip_h = (dir == 1)
