extends CharacterBody2D

class_name Enemy

var speed: float = 100
var player_chase: bool = false
var player: Player = null
var alien_is_dead: bool = false

func _physics_process(delta):
	if player_chase and player != null:
		var direction = (player.global_position - global_position).normalized()
		position += direction*speed*delta
		$AnimatedSprite2D.play("idle")
	move_and_slide()


func _on_detection_area_body_entered(body):
	if body is Player:
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body == player:
		player = null;
		player_chase = false
	


func _on_area_2d_body_entered(body):
	if body.has_method("die"):
		body.die()

func dieAlien():
	if not alien_is_dead:
		player_chase = false
		alien_is_dead = true
		$DeathSound.play()
		$AnimatedSprite2D.play("death")


func _on_gun_gun_pickup(is_picked_up):
	pass # Replace with function body.
