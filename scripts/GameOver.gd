extends Node2D

@export var level_scene_path: String = "res://scenes/world/Level01.tscn"
@export var menu_scene_path: String = "res://scenes/screens/Menu.tscn"

func _ready() -> void:
	var txt := "Game Over"
	var v = get_tree().get_meta("result_text", null)
	if v != null:
		txt = str(v)
	$ResultLabel.text = txt

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file(level_scene_path)
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file(menu_scene_path)
