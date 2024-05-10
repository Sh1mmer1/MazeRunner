extends Control


func _on_play_pressed():
	$ButtonClick.play()
	get_tree().change_scene_to_file("res://UI/levelmenu.tscn")

func _on_levels_pressed():
	$ButtonClick.play()
	pass # Replace with function body.
	
func _on_exit_pressed():
	$ButtonClick.play()
	get_tree().quit()

func _ready():
	$ButtonClick.play()
	$Sprite2D/Main_menu.play("menu")
	$MenuMusic.play()
