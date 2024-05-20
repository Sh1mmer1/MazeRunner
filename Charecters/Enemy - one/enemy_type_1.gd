extends CharacterBody2D

class_name EnemyType2

@export var speed = 100
@export var player: Player
var player_chase: bool = false
var alien_is_dead: bool = false
@onready var nav_agent = $Navigation/NavigationAgent2D
var home_pos = Vector2.ZERO
var target_node = null

func _ready():
	$enemy_animation.play("idle")
	player = $"../Player"
	home_pos = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4

func _physics_process(_delta):
	if not alien_is_dead and player != null and not player.is_dead:
		if nav_agent.is_navigation_finished():
			return
			
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction*speed
		
		move_and_slide()
		


func recalc_path():
	if not alien_is_dead and player and not player.is_dead and target_node:
		nav_agent.target_position = target_node.global_position
	else:
		nav_agent.target_position = home_pos
		
		

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



func _on_detection_area_area_entered(area):
	target_node = area.owner
	$Awake.play()
	$enemy_animation.play("walk_front")


func _on_not_detection_area_area_exited(area):
	if area.owner == target_node:
		target_node = null
		$Sleppy.play()
		$enemy_animation.play("idle")


