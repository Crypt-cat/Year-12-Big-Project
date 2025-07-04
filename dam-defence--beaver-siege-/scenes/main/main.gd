class_name Main
extends Node2D

@export var tower_packed_scene : PackedScene = null 
@export var building_manager : BuildingManager = null
@onready var tile_map_layer : TileMapLayer = $TileMapLayer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position : Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
		
		building_manager.place_tower(cell_position, tower_packed_scene)
		

	
