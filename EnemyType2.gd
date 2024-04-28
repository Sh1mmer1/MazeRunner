extends CharacterBody2D

class_name EnemyType2

@export var speed = 100
@onready var player: Player = null
var player_chase: bool = false
var alien_is_dead: bool = false
@onready var nav_agent = $Navigation/NavigationAgent2D

func _ready():
	$enemy_animation.play("idle")
	player = $"../Player"

func _physics_process(_delta):
	if not alien_is_dead and player != null and not player.is_dead:
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction*speed
		player_chase = true
		move_and_slide()


func recalc_path():
	if not alien_is_dead and player and not player.is_dead:
		nav_agent.target_position = player.global_position
		
func _on_detection_area_body_entered(body):
	pass



func _on_detection_area_body_exited(body):
	pass
	


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
		velocity = Vector2.ZERO
		player.is_gun_picked_up = false
		await $enemy_animation.animation_finished
		queue_free()


func _on_gun_gun_pickup(is_picked_up):
	pass # Replace with function body.


func _on_recalculate_timer_timeout():
	recalc_path()
