extends Area2D

var direction = 1 

func _ready():
	pass 



func _process(delta):
	translate(Vector2.RIGHT * direction)
	$AnimatedSprite2D.flip_h = direction < 0


func _on_timer_timeout():
	direction *= -1
