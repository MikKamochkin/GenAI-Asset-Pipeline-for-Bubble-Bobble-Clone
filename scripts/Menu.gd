extends Node2D

@export var level_scene_path: String = "res://scenes/world/Level01.tscn"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_file(level_scene_path)
