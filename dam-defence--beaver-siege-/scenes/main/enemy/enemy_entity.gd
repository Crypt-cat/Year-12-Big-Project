class_name EnemyEntity
extends CharacterBody2D

@onready var path_node: Path2D = $"../Path2D"  # Adjust to your actual node path
@onready var target_pos: Vector2 = get_path_end_position()

func get_path_end_position() -> Vector2:
	var curve = path_node.curve
	if curve and curve.get_point_count() > 0:
		return curve.get_point_position(curve.get_point_count() - 1)
	else:
		return Vector2.ZERO

var path_array : Array[Vector2i] = []


func _ready() -> void:
	path_array = pathfinding_manager.get_valid_path(global_position / 64, target_pos / 64)


func _process(_delta: float) -> void:
	get_path_to_position()
	move_and_slide()


func get_path_to_position() -> void:
	if len(path_array) > 0:
		var direction : Vector2 = global_position.direction_to(path_array[0])
		
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0)
	else:
		velocity = Vector2i.ZERO
