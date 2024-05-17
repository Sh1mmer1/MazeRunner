extends Area2D

class_name Gun

var gun:AnimatedSprite2D
signal gun_pickup(is_picked_up:bool)
var is_picked_up = false

func _ready():
	gun = $gun
	gun.play("default_gun")

func _on_body_entered(body):
	if body is Player:
		gun_pickup.emit(true)
		queue_free()
		is_picked_up = true
		
