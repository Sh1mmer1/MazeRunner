


func _on_laser_disable_body_entered(body):
	if body.has_method("disable_laser"):
		emit_signal("laser_disabled")
