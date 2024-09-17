extends Area2D


# Called when the node enters the scene tree for the first time.
func collected():
	pass 
	
	

func _on_body_entered(body):
	if body.is_in_group("Player"):
		collected()
		queue_free()
		get_tree().change_scene_to_file("res://eScenes/win.tscn")
