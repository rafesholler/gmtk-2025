extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));

func _on_back_button_pressed() -> void:
	WorldManager.current_room = "res://Menu/Title.tscn"
	WorldManager.next_room.emit()


func _on_master_slider_value_changed(value: float) -> void:
	WorldManager.master_volume = value


func _on_music_slider_value_changed(value: float) -> void:
	WorldManager.music_volume = value


func _on_sound_slider_value_changed(value: float) -> void:
	WorldManager.sound_volume = value

func _on_next_room():
	queue_free()
