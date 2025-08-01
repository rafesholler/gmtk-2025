extends Node2D

var next_scene = 0 #0 = New Game, 1 = Level Select, 3 = Settings

func _ready() -> void:
	WorldManager.loaded_room.emit()
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));
	$CanvasLayer/Menu.connect("newGame", Callable(self,"_on_new_game"));
	$CanvasLayer/Menu.connect("levelSelect", Callable(self,"_on_level_select"));

func _on_new_game():
	WorldManager.current_room = WorldManager.rooms[0]
	WorldManager.next_room.emit()

func _on_level_select():
	WorldManager.current_room = "res://Menu/LevelSelect.tscn"
	WorldManager.next_room.emit()
	
func _on_next_room():
	queue_free()
