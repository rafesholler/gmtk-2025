extends Node2D

func _process(delta: float) -> void:
	print(WorldManager.master_volume)

func _on_back_button_pressed() -> void:
	# Go back to menu
	pass # Replace with function body.


func _on_master_slider_value_changed(value: float) -> void:
	print(value)
	WorldManager.master_volume = value


func _on_music_slider_value_changed(value: float) -> void:
	WorldManager.music_volume = value


func _on_sound_slider_value_changed(value: float) -> void:
	WorldManager.sound_volume = value
