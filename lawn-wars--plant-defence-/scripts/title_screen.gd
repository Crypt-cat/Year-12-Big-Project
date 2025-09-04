extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	# Wait 2 seconds before fading out
	await get_tree().create_timer(2.0).timeout
	animation_player.play("fade_out")

func start_game():
	# Replace with your actual game scene path
	get_tree().change_scene_to_file("res://scenes/lawn.tscn")
