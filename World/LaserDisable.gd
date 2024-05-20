extends Area2D

signal laser_disable





func _on_body_entered(body):
	$LeverAudio.play()
	emit_signal("laser_disable")
