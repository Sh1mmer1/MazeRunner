extends CharacterBody2D

class_name Enemy

var speed: float = 100
var player_chase: bool = false
var player: Player = null
var alien_is_dead: bool = false

func _ready():
	$enemy_animation.play("idle")
	
func _physics_process(delta):
	if player_chase and player != null:
		var direction = (player.global_position - global_position).normalized()
		position += direction*speed*delta
	move_and_slide()


func _on_detection_area_body_entered(body):
	if body is Player:
		if not alien_is_dead:
			player = body
			player_chase = true


func _on_detection_area_body_exited(body):
	if body == player:
		player = null;
		player_chase = false
	


func _on_area_2d_body_entered(body):
	if not alien_is_dead:
		if body.has_method("die"):
			body.die()

func dieAlien():
	if not alien_is_dead:
		player_chase = false
		alien_is_dead = true
		$DeathSound.play()
		$enemy_animation.play("death")
		await $enemy_animation.animation_finished
		queue_free()


func _on_gun_gun_pickup(is_picked_up):
	pass # Replace with function body.
