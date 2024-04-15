extends Area2D

var duration: float = 1.0
var old_speed: float
var speed_change: bool = false
var time: float = 0

func _ready():
	$AnimatedSprite2D.play("default_speed")

func _process(delta):
	if speed_change:
		time += delta
		if time >= duration:
			reset_speed()

func _on_body_entered(body):
	if not speed_change:
		old_speed = body.speed
	body.set_speed(10000.0)
	speed_change = true
	time = 0

func reset_speed():
	var player = get_parent().get_node("../Player")
	if player and player.has_method("set_speed"):
		player.set_speed(old_speed)
		speed_change = false
		time = 0
