extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 1
	
func _on_button_just_pressed() -> void:
	$SlidePlatform.activate()


func _on_button_just_unpressed() -> void:
	$SlidePlatform.deactivate()
	
