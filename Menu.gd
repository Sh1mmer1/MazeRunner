extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World/main.tscn")

func _on_levels_pressed():
	pass # Replace with function body.
	

func _on_exit_pressed():
	get_tree().quit()

func _ready():
	$Sprite2D/Main_menu.play("menu")
	$MenuMusic.play()
