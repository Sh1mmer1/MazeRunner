extends Control


func _on_quit_game_pressed():
	get_tree().paused = false
	get_tree().quit()


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_to_main_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://World/menu.tscn")
