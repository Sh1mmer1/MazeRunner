class_name PauseMenu

extends Control

func _on_continue_button_down():
	$ButtonClick.play()
	get_tree().paused = false
	queue_free()

func _ready():
	get_tree().paused = true


func _on_quit_to_main_button_down():
	$ButtonClick.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://World/menu.tscn")

func _on_quit_game_button_down():
	$ButtonClick.play()
	get_tree().paused = false
	get_tree().quit()
	

func _on_restart_button_down():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://World/main.tscn")
