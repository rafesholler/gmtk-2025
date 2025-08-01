extends TextureButton

func _on_pressed() -> void:
	$SelectSF.play()
	WorldManager.current_room = "res://Menu/Title.tscn"
	WorldManager.next_room.emit()
