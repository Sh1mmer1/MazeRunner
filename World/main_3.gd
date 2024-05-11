extends Node2D

@onready var pause_menu = $TileMap/Player/Camera2D/PauseMenu
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		pause_menu.visible = not pause_menu.visible
