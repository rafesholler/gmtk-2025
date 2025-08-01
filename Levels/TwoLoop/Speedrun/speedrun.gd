extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 2
	$AutoPlatform.activate()


func _on_button_1_just_pressed() -> void:
	$Platform1.activate()


func _on_button_1_just_unpressed() -> void:
	$Platform1.deactivate()


func _on_button_2_just_pressed() -> void:
	$Platform2.activate()


func _on_button_2_just_unpressed() -> void:
	$Platform2.deactivate()


func _on_button_3_just_pressed() -> void:
	$Platform3.activate()


func _on_button_3_just_unpressed() -> void:
	$Platform3.deactivate()


func _on_button_4_just_pressed() -> void:
	$Platform4.activate()


func _on_button_4_just_unpressed() -> void:
	$Platform4.deactivate()


func _on_button_5_just_pressed() -> void:
	$Platform5.activate()


func _on_button_5_just_unpressed() -> void:
	$Platform5.deactivate()


func _on_button_6_just_pressed() -> void:
	$Platform6.activate()


func _on_button_6_just_unpressed() -> void:
	$Platform6.deactivate()
