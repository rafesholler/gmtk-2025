extends Control

func _ready() -> void:
	exit_screen()

func exit_screen():
	var start = get_tree().create_tween()
	start.tween_property($Screen, "position", Vector2(-1500, 0), 1)

func enter_screen():
	var end = get_tree().create_tween()
	end.tween_property($Screen, "position", Vector2(0, 0), 1)
