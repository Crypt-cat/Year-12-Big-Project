class_name EnemySpawner
extends Node2D

signal spawning_phase_complete

@export var enemy_scenes: Dictionary = {
	"Enemy 1": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 2": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 3": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	"Enemy 4": preload("res://scenes/main/enemy/enemy_entity.tscn"),
	}
@export var wave_data_array : Array = ["Enemy 1", "Enemy 2", "Enemy 3", "Enemy 4"]
@export var default_spawn_delay : float = 1.0
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer


var current_spawn_delay : float = 0.0
var current_data_index : int = 0


func start_spawning_wave(wave_data: Array, spawn_delay: float = -1.0) -> void:
	wave_data_array = wave_data
	current_data_index = 0
	current_spawn_delay = spawn_delay if spawn_delay > 0.0 else default_spawn_delay
	enemy_spawn_timer.wait_time = current_spawn_delay
	enemy_spawn_timer.start()


func spawn_entity() -> void:
	if current_data_index >= wave_data_array.size():
		enemy_spawn_timer.stop()
		spawning_phase_complete.emit()
		return

	var enemy_type = wave_data_array[current_data_index]
	var enemy_scene = enemy_scenes.get(enemy_type, null)

	if enemy_scene:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = position  # You can customize spawn position
		add_child(enemy_instance)
	else:
		push_warning("Enemy type '%s' not found in enemy_scenes" % enemy_type)
	
	#print_debug(wave_data_array[current_data_index])


func _on_enemy_spawn_timer_timeout() -> void:
	#print_debug("Enemy Spawned! Wooooo : %s" % current_spawn_delay)
	spawn_entity()
	current_data_index += 1
