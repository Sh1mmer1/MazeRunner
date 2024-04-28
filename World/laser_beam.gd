extends Area2D

var speed: float = 300

func _ready():
	set_as_top_level(true)


func _process(delta):
	var movement = Vector2.RIGHT.rotated(rotation) * delta * speed
	position += movement

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("dieAlien"):
		body.dieAlien()

