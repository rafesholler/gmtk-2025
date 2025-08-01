extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));
	
func _on_next_room():
	queue_free()
