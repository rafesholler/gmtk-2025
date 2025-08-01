extends TextureButton

@export var number = 0

func _on_pressed() -> void:
	get_parent().emit_signal("selected", number)
	WorldManager.room_index = number
