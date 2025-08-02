extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 2


func _on_lever_switched(is_active: bool) -> void:
	var sliders = ["1", "2", "3", "4", "7", "8", "9", "10"]
	
	if is_active:
		for s in sliders:
			get_node("SlidePlatform" + s).activate()
	else:
		for s in sliders:
			get_node("SlidePlatform" + s).deactivate()


func _on_button_just_pressed() -> void:
	$SlidePlatform5.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform5.deactivate()


func _on_button_2_just_pressed() -> void:
	$SlidePlatform6.activate()


func _on_button_2_just_unpressed() -> void:
	$SlidePlatform6.deactivate()
