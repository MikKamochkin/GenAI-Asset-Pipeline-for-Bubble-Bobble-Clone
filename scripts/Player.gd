extends CharacterBody2D

signal hit_by_enemy

@export var move_speed: float = 220.0
@export var jump_velocity: float = -600.0
@export var gravity: float = 1100.0

@export var bubble_scene: PackedScene
@export var fire_cooldown: float = 0.25

@export var invuln_time: float = 0.8
var invuln_timer: float = 0.0

var fire_timer: float = 0.0
var facing: int = 1


func _ready() -> void:
	# Connect hurtbox signal in code so you can’t forget it
	if $Hurtbox != null:
		if not $Hurtbox.body_entered.is_connected(_on_hurtbox_body_entered):
			$Hurtbox.body_entered.connect(_on_hurtbox_body_entered)


func _physics_process(delta: float) -> void:
	# invulnerability countdown
	invuln_timer = max(0.0, invuln_timer - delta)

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal
	var axis := Input.get_axis("move_left", "move_right")
	velocity.x = axis * move_speed

	if axis != 0:
		facing = 1 if axis > 0 else -1
		$Sprite2D.flip_h = (facing == -1)

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Fire cooldown
	fire_timer = max(0.0, fire_timer - delta)
	if Input.is_action_just_pressed("fire") and fire_timer <= 0.0:
		fire_timer = fire_cooldown
		shoot_bubble()

	move_and_slide()


func _on_hurtbox_body_entered(body: Node) -> void:
	if invuln_timer > 0.0:
		return
	if body.is_in_group("enemies"):
		invuln_timer = invuln_time
		emit_signal("hit_by_enemy")


func shoot_bubble() -> void:
	if bubble_scene == null:
		return
	var b := bubble_scene.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position + Vector2(18 * facing, -6)
	b.dir = facing
