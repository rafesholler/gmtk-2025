extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()


func _on_button_1_just_pressed() -> void:
	$SlidePlatform1.activate()


func _on_button_1_just_unpressed() -> void:
	$SlidePlatform1.deactivate()


func _on_button_2_just_pressed() -> void:
	$SlidePlatform2.activate()


func _on_button_2_just_unpressed() -> void:
	$SlidePlatform2.deactivate()
