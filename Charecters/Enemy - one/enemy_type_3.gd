extends CharacterBody2D

class_name EnemyType3

@export var speed = 0.05
@onready var player: Player = null
@export var path_follow_node : PathFollow2D = null

var alien_is_dead: bool = false
var progress_ratio: float = 0.0


func _ready():
	$enemy_animation.play("idle")
	player = $"../../../../Player"
	
	if path_follow_node == null or not (path_follow_node is PathFollow2D):
		print("AA")
		return
	
func _physics_process(delta):
	if not alien_is_dead and player != null and not player.is_dead:
		progress_ratio += delta*speed
		path_follow_node.progress_ratio = progress_ratio
		global_position = path_follow_node.global_position
		
		move_and_slide()



func _on_area_2d_body_entered(body):
	if not alien_is_dead:
		if body.has_method("die"):
			body.die()

func dieAlien():
	if not alien_is_dead:

		alien_is_dead = true
		$DeathSound.play()
		$enemy_animation.play("death")
		velocity = Vector2.ZERO
		player.is_gun_picked_up = false
		queue_free()
		await $enemy_animation.animation_finished
		#queue_free() <- pakeist poto


func _on_gun_gun_pickup(is_picked_up):
	pass # Replace with function body.



