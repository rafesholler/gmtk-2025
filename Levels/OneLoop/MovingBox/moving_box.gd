extends Node2D


func _on_lever_switched(is_active: bool) -> void:
	if is_active:
		$SlidePlatform.activate()
		$SlidePlatform2.activate()
	else:
		$SlidePlatform.deactivate()
		$SlidePlatform2.deactivate()
