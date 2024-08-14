extends Control

@onready var control = $"."

func _input(event):
	if Input.is_action_just_pressed("pause"):
		control.visible = !control.visible
		get_tree().paused = !get_tree().paused
