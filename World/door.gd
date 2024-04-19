extends Area2D

class_name Door
var door:AnimatedSprite2D
var is_open = false

func _ready():
	door = $AnimatedSprite2D
	

			
func _on_body_entered(body):
	print("ENTER")
	if is_open:
		if body is Player:
			Events.victory.emit()
			
func card_count_is_one():
	if not is_open:
		door.play("default_door")
		is_open = true
