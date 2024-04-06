extends CharacterBody2D

var speed: float = 100
var player_chase: bool = false
var player: Player = null


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
