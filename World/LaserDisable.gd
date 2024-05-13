extends Area2D

signal laser_disable





func _on_body_entered(body):
	emit_signal("laser_disable")
