class_name EnemyEntity
extends CharacterBody2D

@onready var paths_parent: Node2D = get_node("Paths")

var target_pos: Vector2

func get_path_end_position(chosen_path) -> Vector2:
	var curve = chosen_path.curve
	if curve and curve.get_point_count() > 0:
		return curve.get_point_position(curve.get_point_count() - 1)
	else:
		return Vector2.ZERO


var paths: Array[Path2D] = []


func _ready():
	paths = []
	for child in paths_parent.get_children():
		if child is Path2D:
			paths.append(child)

	var chosen_path = paths.pick_random()
	target_pos = get_path_end_position(chosen_path)
