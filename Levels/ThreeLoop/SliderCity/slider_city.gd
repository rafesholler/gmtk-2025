extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 3


func _on_button_1_just_pressed() -> void:
	$SlidePlatform2.activate()
	$SlidePlatform3.activate()


func _on_button_1_just_unpressed() -> void:
	$SlidePlatform2.deactivate()
	$SlidePlatform3.deactivate()


func _on_button_2_just_pressed() -> void:
	$SlidePlatform4.activate()


func _on_button_2_just_unpressed() -> void:
	$SlidePlatform4.deactivate()


func _on_button_3_just_pressed() -> void:
	$SlidePlatform5.activate()


func _on_button_3_just_unpressed() -> void:
	$SlidePlatform5.deactivate()


func _on_lever_switched(is_active: bool) -> void:
	if is_active:
		$SlidePlatform1.activate()
		$SlidePlatform6.activate()
	else:
		$SlidePlatform1.deactivate()
		$SlidePlatform6.deactivate()
