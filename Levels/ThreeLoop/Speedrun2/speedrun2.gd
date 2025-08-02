extends Node2D

var towards_start = false
var auto_sliders = ["4", "5", "6", "7", "8"]

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 3


func _on_timer_timeout() -> void:
	if towards_start:
		for s in auto_sliders:
			get_node("SlidePlatform" + s).activate()
	else:
		for s in auto_sliders:
			get_node("SlidePlatform" + s).deactivate()
	
	towards_start = not towards_start


func _on_lever_1_switched(is_active: bool) -> void:
	$EndPlatform1.activate()


func _on_lever_2_switched(is_active: bool) -> void:
	$EndPlatform2.activate()


func _on_lever_3_switched(is_active: bool) -> void:
	$EndPlatform3.activate()


func _on_button_just_pressed() -> void:
	$SlidePlatform1.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform1.deactivate()


func _on_button_2_just_pressed() -> void:
	$SlidePlatform2.activate()


func _on_button_2_just_unpressed() -> void:
	$SlidePlatform2.deactivate()


func _on_button_3_just_pressed() -> void:
	$SlidePlatform3.activate()


func _on_button_3_just_unpressed() -> void:
	$SlidePlatform3.deactivate()
