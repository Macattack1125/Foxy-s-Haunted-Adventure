extends Button

@onready var margin_container: MarginContainer = $"../MarginContainer"
@onready var buttons = [$"../Start", $".",$"../Quit"]

func _pressed() -> void:
	get_tree().change_scene_to_file("res://eScenes/optionss.tscn")
