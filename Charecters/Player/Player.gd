extends CharacterBody2D

class_name Player

signal player_dead

@export var speed : float = 2.0
var is_dead: bool = false

var animated_sprite: AnimatedSprite2D
var body_sprite: Sprite2D
var is_animating: bool = false
var enemy: Enemy = null
var is_gun_picked_up:bool = false
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D


func _ready():
	animated_sprite = $AnimatedSprite2D
	body_sprite = $Body
	
	body_sprite.visible = true
	animated_sprite.visible = false
	animation_player.play("idle_main")

	
func _physics_process(delta):
	if not is_dead:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()

		if direction != Vector2.ZERO:
			velocity = direction * speed * delta * 3
			update_sprite_direction(direction)
		else:
			velocity = Vector2.ZERO
			if is_animating:
				animated_sprite.stop()
				is_animating = false
				body_sprite.visible = true
				animated_sprite.visible = false
			
		move_and_slide()

func update_sprite_direction(direction):
	var animation_name = "front_walk" 
	
	if direction == Vector2(0, 1):
		animation_name = "front_walk"
	elif direction == Vector2(0, -1):
		animation_name = "back_walk"
	elif direction == Vector2(1, 0):
		animation_name = "right_walk"
	elif direction == Vector2(-1, 0):
		animation_name = "left_walk"
		
	if not is_animating:
		animated_sprite.play(animation_name)
		is_animating = true
		body_sprite.visible = false
		animated_sprite.visible = true
	else:
		if $Timer.time_left <= 0:
			$footstep.pitch_scale = randf_range(0.8, 1.2)
			$footstep.play()
			$Timer.start(1)

func die():
	if not is_dead:
		is_dead = true
		$DeathSound.play()
		animated_sprite.visible = false
		body_sprite.visible = true
		animation_player.play("death")

func set_speed(new_speed: float): 
	speed = new_speed


func _on_range_body_entered(body):
	if is_gun_picked_up:
		if body.has_method("dieAlien"):
			body.dieAlien()


func _on_gun_gun_pickup(is_picked_up):
	is_gun_picked_up = is_picked_up
