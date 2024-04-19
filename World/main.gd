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
