extends Button

@onready var margin_container: MarginContainer = $"../MarginContainer"
@onready var buttons = [$"../Start", $".",$"../Quit"]

func _pressed() -> void:
	for button in buttons:
		button.visible = !button.visible
	margin_container.visible = !margin_container.visible
