class_name EnemySpawner
extends Node2D

signal spawning_phase_complete

@export var enemy_scenes: Dictionary = {
	"Enemy 1": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 2": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 3": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 4": preload("res://scenes/main/enemy/enemy_entity.tscn"),
}
@export var default_spawn_delay: float = 1.0
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var spawn_points_parent: Node2D = $SpawnPoints
var spawn_points: Array = []

var wave_data_array: Array = []
var current_data_index: int = 0
var current_spawn_delay: float = 1.0

func _ready():
	print("EnemySpawner ready")
	enemy_spawn_timer.timeout.connect(_on_enemy_spawn_timer_timeout)

	for child in spawn_points_parent.get_children():
		if child is Marker2D:
			spawn_points.append(child)
	
	if spawn_points.size() == 0:
		push_error("No spawn points found!")

func start_spawning_wave(wave_data: Array, spawn_delay: float = -1.0) -> void:
	print("start_spawning_wave called")
	wave_data_array = wave_data
	current_data_index = 0
	current_spawn_delay = spawn_delay if spawn_delay > 0.0 else default_spawn_delay
	enemy_spawn_timer.wait_time = current_spawn_delay
	enemy_spawn_timer.start()
	print("Spawn timer started with delay:", current_spawn_delay)

func _on_enemy_spawn_timer_timeout():
	print("Spawn timer timeout reached")
	spawn_entity()
	current_data_index += 1

func spawn_entity():
	if current_data_index >= wave_data_array.size():
		print("Spawning phase complete")
		enemy_spawn_timer.stop()
		spawning_phase_complete.emit()
		return

	var enemy_type = wave_data_array[current_data_index]
	print("Spawning enemy of type:", enemy_type)

	var enemy_scene = enemy_scenes.get(enemy_type, null)
	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate()
		var spawn_point = spawn_points.pick_random()
		enemy_instance.position = spawn_point.global_position 
		get_tree().current_scene.add_child(enemy_instance) 
	else:
		push_warning("Enemy type '%s' not found in enemy_scenes" % enemy_type)
