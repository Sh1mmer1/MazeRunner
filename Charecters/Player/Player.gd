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
var gun_cooldown = false
var laser_beam = preload("res://World/laser_beam.tscn")
var target_position: Vector2 = Vector2.ZERO
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var fire_timer = $FireTimer
@onready var spaceship = $"../../Spaceship/AnimatedSprite2D"


func _ready():
	animated_sprite = $AnimatedSprite2D
	body_sprite = $Body

	animated_sprite.visible = false	
	body_sprite.visible = false
	if spaceship == null:
		body_sprite.visible = true
		animation_player.play("idle_main")
		animated_sprite.visible = false
	if is_gun_picked_up:
		animation_player.play("idle_main_gun")
	fire_timer.wait_time = 0.2
	fire_timer.one_shot = false
	fire_timer.paused = false

func _physics_process(delta):
	if spaceship != null:
		if spaceship.frame < 25:
			is_dead = true
		else:
			is_dead = false
		if spaceship.frame >= 20 and spaceship.frame != 25:
			body_sprite.visible = true
			animation_player.play("idle_main")
			animated_sprite.visible = false

	if not is_dead:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		$Marker2D.look_at(direction)
		
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
				if is_gun_picked_up:
					animation_player.play("idle_main_gun")
				else:
					animation_player.play("idle_main")
			
		move_and_slide()

func update_sprite_direction(direction):
	var animation_name = "" 
	
	if direction == Vector2(0, 1):
		animation_name = "front_walk"
	elif direction == Vector2(0, -1):
		animation_name = "back_walk"
	elif direction == Vector2(1, 0):
		animation_name = "right_walk"
	elif direction == Vector2(-1, 0):
		animation_name = "left_walk"
	
	if is_gun_picked_up:
		animation_name += "_gun"
	
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
		$LoserAudio.play()
		await animation_player.animation_finished
		Events.gameOver.emit()


func set_speed(new_speed: float): 
	speed = new_speed


func _on_range_body_entered(body):
	if is_gun_picked_up and not gun_cooldown:
		target_position = body.global_position
		fire_timer.start()
		fire_laser()
		$GunFireAudio.play()



func _on_gun_gun_pickup(is_picked_up):
	is_gun_picked_up = is_picked_up
	$PickUpItem.play()

func stop_player_movement():
	is_dead = true
	animated_sprite.visible = false
	body_sprite.visible = true

func fire_laser():
	if is_gun_picked_up:
		var gun_instance = laser_beam.instantiate()
		
		var direction = (target_position - $Marker2D.global_position).normalized()
		gun_instance.rotation = direction.angle()
		gun_instance.global_position = $Marker2D.global_position

		add_child(gun_instance)
		

func _on_range_body_exited(body):
	fire_timer.stop()

