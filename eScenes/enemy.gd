extends Area2D

var direction = 1
func _ready():
	pass 


func _process(delta):
	translate(Vector2.RIGHT * direction)
	


func _on_timer_timeout() -> void:
	pass # Replace with function body.
