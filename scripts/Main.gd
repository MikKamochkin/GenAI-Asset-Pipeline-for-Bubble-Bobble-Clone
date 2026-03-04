extends Node

@export var menu_scene_path: String = "res://scenes/screens/Menu.tscn"

func _ready() -> void:
	get_tree().change_scene_to_file(menu_scene_path)
