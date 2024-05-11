extends Area2D

@onready var laser: Sprite2D = $laser
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var player: Player = null
var on: bool = true
var animation_finished: bool = true
@onready var offButton = $"../LaserDisable/OffButton"
@onready var onButton = $"../LaserDisable/OnButton"
@onready var LaserOFF = $LaserOFF
@onready var LaserBeam = $LaserBeam

func _process(delta):
	if on == false and animation_finished == true:
		if animation_finished:
			animation_player.play("default")
			LaserOFF.play()
			animation_finished = false

func _on_body_entered(body):
	if on == true:
		if body.has_method("die"):
			body.die()

func _on_laser_animation_finished():
	animation_finished = true
	animation_player.stop()



func _on_laser_disable_body_entered(body):
	on = false
	onButton.visible = false
	offButton.visible = true
