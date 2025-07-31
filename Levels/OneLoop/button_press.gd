extends Node2D


func _on_button_just_pressed() -> void:
	$SlidePlatform.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform.deactivate()
