extends Node2D


func _ready() -> void:
	get_tree().paused = true
	
	$CanvasLayer/Control/Settings.visible = false
	$CanvasLayer/Control/Panel.visible = true
	
	$CanvasLayer/Control/Settings/Audio/MasterVolume/MasterSlider.value = WorldManager.master_volume
	$CanvasLayer/Control/Settings/Audio/MusicVolume/MusicSlider.value = WorldManager.music_volume
	$CanvasLayer/Control/Settings/Audio/SoundVolume/SoundSlider.value = WorldManager.sound_volume


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_continue_pressed()


func _on_continue_pressed() -> void:
	$SelectSF.play()
	get_tree().paused = false
	call_deferred("queue_free")


func _on_settings_pressed() -> void:
	$SelectSF.play()
	$CanvasLayer/Control/Settings.visible = true
	$CanvasLayer/Control/Panel.visible = false


func _on_title_pressed() -> void:
	$SelectSF.play()
	get_tree().paused = false
	WorldManager.room_index = -1
	WorldManager.next_room.emit()


func _on_save_settings_pressed() -> void:
	$SelectSF.play()
	$CanvasLayer/Control/Settings.visible = false
	$CanvasLayer/Control/Panel.visible = true


func _on_master_slider_value_changed(value: float) -> void:
	WorldManager.master_volume = value


func _on_music_slider_value_changed(value: float) -> void:
	WorldManager.music_volume = value


func _on_sound_slider_value_changed(value: float) -> void:
	WorldManager.sound_volume = value


func _on_master_slider_drag_started() -> void:
	$SelectSF.play()


func _on_music_slider_drag_started() -> void:
	$SelectSF.play()


func _on_sound_slider_drag_started() -> void:
	$SelectSF.play()
