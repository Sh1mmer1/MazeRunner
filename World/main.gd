extends Node2D

@onready var victory = $CanvasLayer/victory
@onready var gameOver = $CanvasLayer/gameOver
@onready var player = $TileMap/Player
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.victory.connect(show_victory)
	Events.gameOver.connect(show_game_over)
	Events.victory.connect(stop_player_movement)

func show_victory():
	victory.show()

func show_game_over():
	gameOver.show()

func stop_player_movement():
	player.stop_player_movement()
	
@export var pause_menu_packed_scene : PackedScene = null
@onready var pause = $CanvasLayer2 as CanvasLayer

func _unhandled_key_input(event) -> void:
	if event.is_action("pause"):
		var new_pause_menu : PauseMenu = pause_menu_packed_scene.instantiate()
		
		pause.add_child(new_pause_menu)


