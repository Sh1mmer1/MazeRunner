extends CharacterBody2D

class_name Player

signal player_dead

@export var speed : float = 2.0
var is_dead: bool = false

var animated_sprite: AnimatedSprite2D
var body_sprite: Sprite2D
var is_animating: bool = false
var is_walking: bool = false
var enemy: Enemy = null
var is_gun_picked_up:bool = false
var gun_cooldown = true
var laser_beam = preload("res://World/laser_beam.tscn")
var target_position: Vector2 = Vector2.ZERO
var ray_cast_direction: Vector2 = Vector2.ZERO
var target
var hit_pos
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var fire_timer = $FireTimer
@onready var spaceship = $"../../Spaceship/AnimatedSprite2D"
@onready var detection = $Range/ShootRange
@onready var ray_cast = $Range/RayCast2D

func _ready():
	animated_sprite = $AnimatedSprite2D
	body_sprite = $Body

	animated_sprite.visible = false	
	body_sprite.visible = false
	animation_tree.set("parameters/Walk/blend_position", 0.0)
	animation_tree.set("parameters/Walk_Gun/blend_position", 0.0)
	if spaceship == null:
		body_sprite.visible = true
		animation_tree.get("parameters/playback").travel("Idle")
		animated_sprite.visible = false
	if is_gun_picked_up:
		animation_tree.get("parameters/playback").travel("Idle_Gun")
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
			animation_tree.get("parameters/playback").travel("Idle")
			animated_sprite.visible = false

	if not is_dead:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		$Marker2D.look_at(direction)

		if direction != Vector2.ZERO:
			play_footsteps()
			is_walking = true
			velocity = direction * speed * delta * 3
			animation_tree.set("parameters/Walk/blend_position", direction)
			animation_tree.get("parameters/playback").travel("Walk")
			if is_gun_picked_up:
				animation_tree.set("parameters/Walk_Gun/blend_position", direction)
				animation_tree.get("parameters/playback").travel("Walk_Gun")
			
			#$AnimationTree.set("parameters/Walk/blend_position", velocity)
			#update_sprite_direction(direction)
		

		else:
			velocity = Vector2.ZERO
			$footstep.stop()
			is_walking = false
			animation_tree.get("parameters/playback").travel("Idle")
			if is_gun_picked_up:
				animation_tree.get("parameters/playback").travel("Idle_Gun")
			if is_animating:
				animated_sprite.stop()
				is_animating = false
				body_sprite.visible = true
				animated_sprite.visible = false
				if is_gun_picked_up:
					animation_tree.get("parameters/playback").travel("Idle_Gun")
				else:
					animation_tree.get("parameters/playback").travel("Idle")
			
		move_and_slide()
	
		

	queue_redraw()
	if target:
		aim()
		
func play_footsteps():
	if $Timer.time_left <= 0:
		$footstep.pitch_scale = randf_range(0.8, 1.2)
		$footstep.play()
		$Timer.start(0.4)
		
func aim():
	var space_state = get_world_2d().get_direct_space_state()
	var params = PhysicsRayQueryParameters2D.new()
	params.from = position
	params.to = target.position
	params.exclude = [self]
	params.collision_mask = collision_mask
	var result = space_state.intersect_ray(params)
	if result:
		hit_pos = result.position
		var collider = result.collider 
		if collider and collider.is_in_group("Enemies"):
			if gun_cooldown:
				fire_laser(target.position)

#func update_sprite_direction(direction):
#	var animation_name = "" 

#	if velocity.y > 0:
#		animation_name = "front_walk"
#	elif velocity.y < 0:
#		animation_name = "back_walk"
#	elif velocity.x > 0:
#		animation_name = "right_walk"
#	elif velocity.x < 0:
#		animation_name = "left_walk"
		
#	if is_gun_picked_up:
#		animation_name += "_gun"
#	
#	
#	if not is_animating:
#		#animated_sprite.play(animation_name)
#		is_animating = true
#		body_sprite.visible = true
#		animation_player.play(animation_name)
#		animated_sprite.visible = false
#	else:
#		if $Timer.time_left <= 0:
#			$footstep.pitch_scale = randf_range(0.8, 1.2)
#			$footstep.play()
#			$Timer.start(1)

func die():
	if not is_dead:
		is_dead = true
		$DeathSound.play()
		animated_sprite.visible = false
		body_sprite.visible = true
		animation_tree.get("parameters/playback").travel("Death")
		$LoserAudio.play()
		await animation_tree.animation_finished
		Events.gameOver.emit()


func set_speed(new_speed: float): 
	speed = new_speed


func _on_range_body_entered(body):
	if is_gun_picked_up:
		if target:
			("Target found")
			return
		target = body



func _on_gun_gun_pickup(is_picked_up):
	is_gun_picked_up = is_picked_up
	$PickUpItem.play()

func stop_player_movement():
	is_dead = true
	animated_sprite.visible = false
	body_sprite.visible = true

func fire_laser(pos):

	if is_gun_picked_up:
		var b = laser_beam.instantiate()
		var a = (pos - global_position).angle()
		b.start(global_position, a + randf_range(-0.5, 0.5))
		get_parent().add_child(b)
		gun_cooldown = false
		fire_timer.start()

func _on_range_body_exited(body):
	if body == target:
		target = null

func _on_fire_timer_timeout():
	gun_cooldown = true
