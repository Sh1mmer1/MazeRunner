extends Control




func _on_button_pressed():
	get_tree().change_scene_to_file("res://World/menu.tscn")


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://World/main.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://World/main_2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://World/main_3.tscn")
