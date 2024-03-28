extends CollisionShape2D

signal laser_disabled

func _ready():
	set_deferred("collision_layer", 0) 
	set_deferred("collision_mask", 0) 

func _on_body_entered(body):
	if body.has_method("disable_laser"):
		emit_signal("laser_disabled")
