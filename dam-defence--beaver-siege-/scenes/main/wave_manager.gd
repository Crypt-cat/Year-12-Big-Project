extends Node

@onready var enemy_spawner = get_parent().get_node("EnemySpawner")
@export var wave_start_delay: float = 3.0
var current_wave: int = 1

func _ready():
	print("WaveManager ready")
	enemy_spawner.spawning_phase_complete.connect(_on_spawning_phase_complete)
	start_wave()

func start_wave():
	print("Starting wave", current_wave)
	var wave_data = generate_wave_data(current_wave)
	print("Generated wave data:", wave_data)
	enemy_spawner.start_spawning_wave(wave_data)

func _on_spawning_phase_complete():
	print("Wave", current_wave, "complete")
	current_wave += 1
	await get_tree().create_timer(wave_start_delay).timeout
	start_wave()

func generate_wave_data(wave_number: int) -> Array:
	var enemies = []
	var num_enemies = 3 + wave_number * 2
	for i in range(num_enemies):
		var enemy_type = "Enemy " + str(randi() % 4 + 1)
		enemies.append(enemy_type)
	return enemies
