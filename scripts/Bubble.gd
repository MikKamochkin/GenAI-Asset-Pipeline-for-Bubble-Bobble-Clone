extends Area2D

signal popped(points_awarded: int)

@export var horizontal_speed: float = 320.0
@export var float_speed: float = 90.0
@export var horizontal_time: float = 0.35
@export var life_time: float = 3.0
@export var points: int = 200

var dir: int = 1
var t: float = 0.0
var floating_up: bool = false

var trapped_enemy: Node2D = null
var is_trapped: bool = false


func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

	$LifeTimer.wait_time = life_time
	$LifeTimer.one_shot = true
	$LifeTimer.start()
	$LifeTimer.timeout.connect(queue_free)


func _physics_process(delta: float) -> void:
	t += delta

	if trapped_enemy != null and is_instance_valid(trapped_enemy):
		trapped_enemy.global_position = global_position

	if not floating_up and t >= horizontal_time:
		floating_up = true

	if floating_up:
		position.y -= float_speed * delta
	else:
		position.x += dir * horizontal_speed * delta


func _on_body_entered(body: Node) -> void:
	# Player pops trapped bubble
	if is_trapped and body.name == "Player":
		pop()
		return

	# Only trap once
	if is_trapped:
		return

	# Trap enemy root (group-based)
	var enemy_root := find_enemy_root(body)
	if enemy_root != null:
		trap_enemy(enemy_root)


func find_enemy_root(n: Node) -> Node2D:
	var cur := n
	while cur != null:
		if cur.is_in_group("enemies") and cur is Node2D:
			return cur as Node2D
		cur = cur.get_parent()
	return null


func trap_enemy(enemy: Node2D) -> void:
	is_trapped = true
	trapped_enemy = enemy

	if enemy.has_method("set_trapped"):
		enemy.call("set_trapped", true)
	else:
		enemy.set_physics_process(false)


func pop() -> void:
	if trapped_enemy != null and is_instance_valid(trapped_enemy):
		trapped_enemy.queue_free()
	trapped_enemy = null

	emit_signal("popped", points)
	queue_free()
