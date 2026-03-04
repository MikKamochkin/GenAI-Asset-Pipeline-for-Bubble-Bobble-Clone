extends Node2D

@export var player_spawn: Vector2 = Vector2(100, 100)
@export var score_to_win: int = 600

@export var gameover_scene_path: String = "res://scenes/screens/GameOver.tscn"

var score: int = 0
var lives: int = 3


func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)
	update_hud()


func _on_node_added(n: Node) -> void:
	
	if n.has_signal("popped"):
		if not n.popped.is_connected(_on_bubble_popped):
			n.popped.connect(_on_bubble_popped)


func _on_bubble_popped(points_awarded: int) -> void:
	score += points_awarded
	update_hud()

	# WIN condition
	if score >= score_to_win:
		go_to_gameover(true)


func _on_player_hit_by_enemy() -> void:
	lives -= 1
	update_hud()

	# DEAD condition
	if lives <= 0:
		go_to_gameover(false)
	else:
		respawn_player()


func respawn_player() -> void:
	$Player.global_position = player_spawn
	$Player.velocity = Vector2.ZERO


func update_hud() -> void:
	$HUD/ScoreLabel.text = "Score: %d" % score
	$HUD/LivesLabel.text = "Lives: %d" % lives


func go_to_gameover(won: bool) -> void:
	# Store a message so GameOver screen can display WIN/LOSE
	var msg := ""
	if won:
		msg = "You Win! Score: %d" % score
	else:
		msg = "You Died! Score: %d" % score

	get_tree().set_meta("result_text", msg)

	# Load gameover
	get_tree().change_scene_to_file(gameover_scene_path)
