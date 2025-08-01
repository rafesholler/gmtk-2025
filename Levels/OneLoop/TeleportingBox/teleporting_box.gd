extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
