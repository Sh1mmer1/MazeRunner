extends CharacterBody2D

class_name Player

signal player_dead

@export var speed : float = 3.0
var is_dead: bool = false

var animated_sprite: AnimatedSprite2D
var body_sprite: Sprite2D
var is_animating: bool = false
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
			velocity = direction * speed * delta * 5
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

func die():
	if not is_dead:
		is_dead = true
		animated_sprite.visible = false
		body_sprite.visible = true
		animation_player.play("death")
