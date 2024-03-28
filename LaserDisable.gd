extends Area2D

class_name LaserDisable

signal laser_disabled



func _on_body_entered(body):
	if body.has_method("disable_laser"):
		emit_signal("laser_disabled")


func _on_laser_disabled():
	get_tree().call_group("Lasers", "_on_laser_disabled")
