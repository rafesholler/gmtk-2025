extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 3
	
func _on_button_just_pressed() -> void:
	$SlidePlatform.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform.deactivate()


func _on_button_2_just_pressed() -> void:
	$SlidePlatform2.activate()

func _on_button_2_just_unpressed() -> void:
	$SlidePlatform2.deactivate()


func _on_button_3_just_pressed() -> void:
	$SlidePlatform3.activate()


func _on_button_3_just_unpressed() -> void:
	$SlidePlatform3.deactivate()


func _on_button_4_just_pressed() -> void:
	$SlidePlatform4.activate()


func _on_button_4_just_unpressed() -> void:
	$SlidePlatform4.deactivate()
