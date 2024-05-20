extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.has_method("die"):
		$SpikeAudio.play()
		$AnimatedSprite2D.play("activate")
		body.die()

