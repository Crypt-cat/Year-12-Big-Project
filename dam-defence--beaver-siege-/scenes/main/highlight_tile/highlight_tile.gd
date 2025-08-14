class_name HighlightTile
extends Node2D


func _process(_delta: float) -> void:
	follow_mouse_position()


func follow_mouse_position() -> void:
	var mouse_position : Vector2i = get_global_mouse_position() / 16
	
	position = mouse_position * 16
