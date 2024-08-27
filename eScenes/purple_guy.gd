extends CharacterBody2D

var direction = 1
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

const DEATH_EFFECT = preload("res://eScenes/death_effect.tscn")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	velocity.x = direction * SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()
	$AnimatedSprite2D.flip_h = direction > 0

func die():
	var new_explosion = DEATH_EFFECT.instantiate()
	new_explosion.global_position = global_position
	get_tree().current_scene.add_child(new_explosion)
	GameManger.score +=50
	queue_free()
	

func _on_timer_timeout() -> void:
	direction = direction * -1
