extends Node2D

var current_room = preload("res://Levels/OneLoop/1.tscn")

func _ready() -> void:
	WorldManager.connect("load_next_room", Callable(self,"_load_next_room"));
	add_child(current_room.instantiate())

func _load_next_room():
	current_room = load("res://Levels/OneLoop/"+str(WorldManager.current_room)+".tscn")
	add_child(current_room.instantiate())
