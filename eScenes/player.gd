extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
@export var acceleration : float = 15.0
@export var jumps = 1

enum state {IDEL, RUNNING, JUMPUP, JUMPDOWN, HURT}

var anim_state = state.IDEL

@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") # Gets gravity on the player
@onready var start_pos = global_position

func reset(): # This function clears the current score upon death
	
	GameManger.score = 0 # Score set zero
	get_tree().reload_current_scene() # This code here reloads the current scene which also respawns enemies

func update_state(): # This function updates the player state which then can be used for changing animations 
	if anim_state == state.HURT:
		return
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDEL # For idle animation
		elif velocity.x != 0:
			anim_state = state.RUNNING # For run/walk animation
	else:
		if velocity.y < 0:
			anim_state = state.JUMPUP # Animation for when jumping
		else:
			anim_state = state.JUMPDOWN # Animation for when falling

func update_animation(direcion): # This updates the animation based off of the direction moving and the current state
	if direcion > 0:
		animator.flip_h = false
	elif  direcion <0:
		animator.flip_h = true
	match anim_state:
		state.IDEL:
			animation_player.play('idel')
		state.RUNNING:
			if Input.is_action_pressed("run"):
				animation_player.play("run")
			else:
				animation_player.play("walk")
		state.JUMPUP:
			animation_player.play('jump_up')
		state.JUMPDOWN:
			animation_player.play("jump_down")
		state.HURT:
			animation_player.play("hurt")


func _physics_process(delta): # This here handles the movement and jumping
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	var direction = Input.get_axis("left", "right")
	if direction:
		if Input.is_action_pressed("run"):
			velocity.x = move_toward(velocity.x,direction*speed+50,acceleration)
		else:
			velocity.x = move_toward(velocity.x,direction*speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * 2.5)
	update_state()
	update_animation(direction)
	move_and_slide()

func enemy_checker(enemy): # Checks if the enemy is actually an enemy
	if enemy.is_in_group("Enemy") and velocity.y > 0:
		enemy.die()
		velocity.y = jump_velocity
	elif enemy.is_in_group("Hurt"):
		anim_state = state.HURT

func _on_hitobx_area_entered(area) -> void: # Detects an object entering the hitbox
	enemy_checker(area)


func _on_hitobx_body_entered(body: Node2D) -> void: # Also detects an object entering the hitbox
	enemy_checker(body)
