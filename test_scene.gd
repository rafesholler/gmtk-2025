extends Node2D


func _on_button_just_pressed() -> void:
	$SlidePlatform.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform.deactivate()


func _on_lever_switched(is_active: bool) -> void:
	if is_active:
		$SlidePlatform.activate()
	else:
		$SlidePlatform.deactivate()
