extends Node2D
func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 3

func _on_button_2_just_pressed() -> void:
	$SlidePlatform2.activate()

func _on_button_2_just_unpressed() -> void:
	$SlidePlatform2.deactivate()

func _on_button_just_pressed() -> void:
	pass # Replace with function body.
func _on_button_just_unpressed() -> void:
	pass # Replace with function body.


func _on_button3_just_pressed() -> void:
	$SlidePlatform3.activate()


func _on_button3_just_unpressed() -> void:
	$SlidePlatform3.deactivate()


func _on_button_4_just_pressed() -> void:
	$SlidePlatform4.activate()


func _on_button_4_just_unpressed() -> void:
	$SlidePlatform4.deactivate()


func _on_button_nothing_just_pressed() -> void:
	$SlidePlatformNOTHING.activate()


func _on_button_nothing_just_unpressed() -> void:
	$SlidePlatformNOTHING.deactivate()


func _on_button_nothing_2_just_pressed() -> void:
	$SlidePlatformNOTHING2.activate()


func _on_button_nothing_2_just_unpressed() -> void:
	$SlidePlatformNOTHING2.deactivate()


func _on_lever_switched(is_active: bool) -> void:
	$SlidePlatform8.activate()


func _on_button_5_just_pressed() -> void:
	$SlidePlatform5.activate()


func _on_button_5_just_unpressed() -> void:
	$SlidePlatform5.deactivate()


func _on_button_6_just_pressed() -> void:
	$SlidePlatform6.activate()


func _on_button_6_just_unpressed() -> void:
	$SlidePlatform6.deactivate()


func _on_button_7_just_pressed() -> void:
	$SlidePlatform7.activate()


func _on_button_7_just_unpressed() -> void:
	$SlidePlatform7.deactivate()


func _on_button_9_just_pressed() -> void:
	$SlidePlatform9.activate()


func _on_button_9_just_unpressed() -> void:
	$SlidePlatform9.deactivate()


func _on_button_final_1_just_pressed() -> void:
	$SlidePlatformFinal1.activate()


func _on_button_final_1_just_unpressed() -> void:
	$SlidePlatformFinal1.deactivate()


func _on_button_11_just_pressed() -> void:
	$SlidePlatform11.activate()


func _on_button_11_just_unpressed() -> void:
	$SlidePlatform11.deactivate()


func _on_button_12_just_pressed() -> void:
	$SlidePlatform12.activate()


func _on_button_12_just_unpressed() -> void:
	$SlidePlatform12.deactivate()


func _on_button_10_just_pressed() -> void:
	$SlidePlatform10.activate()


func _on_button_10_just_unpressed() -> void:
	$SlidePlatform10.deactivate()
