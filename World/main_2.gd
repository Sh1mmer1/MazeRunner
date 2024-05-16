extends Node2D

@onready var player = $TileMap/Player
# Called when the node enters the scene tree for the first time.

func _ready():
	Events.victory.connect(show_victory)
	Events.gameOver.connect(show_game_over)
	Events.victory.connect(stop_player_movement)

func show_victory():
	get_tree().change_scene_to_file("res://UI/winscreen.tscn")

func show_game_over():
	get_tree().change_scene_to_file("res://UI/losescreen.tscn")

func stop_player_movement():
	player.stop_player_movement()
	

@onready var pause_menu = $TileMap/Player/Camera2D2/PauseMenu
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		pause_menu.visible = not pause_menu.visible
