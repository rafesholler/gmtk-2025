extends Control

func _ready() -> void:
	WorldManager.connect("next_room", Callable(self,"_on_next_room")); 
	WorldManager.connect("loaded_room", Callable(self, "_on_room_load"))

func _on_next_room():
	$Transition.enter_screen()
	LoopManager.cancel_all_loops()

func _on_room_load():
	$Transition.exit_screen()
